import pymysql.cursors

conn = pymysql.connect(host='localhost',
            user='root',
            password ='thongtete1',
            db='dbclass',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor)
import random
import string

def randomString(stringLength=10):
    """Generate a random string of fixed length """
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(stringLength))

import csv
idx = 0
try:
  with conn.cursor() as cursor:

    # insertHostSql = "INSERT INTO Host(huid, last_name, first_name, email, password) VALUES(%s, %s, %s, %s, %s)"
    # insertRoomSql = "INSERT INTO Room(room_id, x_coordinate, y_coordinate, price) VALUES (%s, %s, %s, %s)"
    # cursor.execute(insertHostSql, (1,randomString(), "sdad", randomString() + "@gmail.com", randomString()))
    # cursor.execute(insertRoomSql, (1,22.3, 34.1, 32 ))
    # conn.commit()

    with open('AB_NYC_2019.csv') as csv_file:

      roomId = 1

      csv_reader = csv.reader(csv_file, delimiter=',')
      for row in csv_reader:
        if idx == 0:
          idx += 1
          continue
        else:
          room_type = row[8]
          name = row[1]
          host_id = int(row[2])
          host_name = row[3]
          neightbourhood_group = row[4]
          neightbourhood = row[5]
          latitude = float(row[6])
          longitude = float(row[7])
          price = float(row[9])
          minimum_nights = row[10]
          number_of_reviews = row[11]
          last_review = row[12]
          reviews_per_month = row[13]
          calculated_host_listings_count = row[14]
          availability_365 = row[15]
          insertHostSql = "INSERT INTO Host(huid, last_name, first_name, email, password) VALUES(%s, %s, %s, %s, %s)"

          selectHostSql = "SELECT huid from Host where huid=%s"
          cursor.execute(selectHostSql, (host_id))
          result = cursor.fetchone()
          if result == None:
            cursor.execute(insertHostSql, (host_id,randomString(), host_name, randomString() + "@gmail.com", randomString()))

          selectRoomSql = "SELECT room_id from Room where room_id=%s"
          cursor.execute(selectRoomSql, (roomId))
          if (cursor.fetchone() == None):
            insertRoomSql = "INSERT INTO Room(room_id, x_coordinate, y_coordinate, price) VALUES (%s, %s, %s, %s)"
            cursor.execute(insertRoomSql, (roomId,latitude, longitude, price ))

          listingInsertSQL = "INSERT INTO Listing(listing_title, host_id, admin_id) VALUES(%s, %s, %s)";
          cursor.execute(listingInsertSQL, (name, host_id, 1));
          conn.commit()

          if room_type == "Private room":
            insertPrivateRoomSql = "INSERT INTO private_room(x_coordinate, y_coordinate, price, room_id, host_id, no_of_beds, privateroom_type) VALUES(%s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(insertPrivateRoomSql, (float(latitude), float(longitude), float(price), roomId, host_id, 1, "Small") )
          elif room_type == "Entire home/apt":
            insertEntireHomeSql = "INSERT INTO EntireHouse_or_Appt(x_coordinate, y_coordinate, price, room_id, host_id,no_of_rooms ) VALUES(%s, %s, %s, %s, %s, %s)"
            cursor.execute(insertEntireHomeSql, (float(latitude), float(longitude), float(price), roomId, host_id, 1) )

          roomId += 1
          conn.commit()


finally:
  conn.close()
