DATABASE_URL = "sqlite:db/database.sqlite3"

.PHONY: dbmate.new dbmate.up dbmate.down dbmate.status sqlc.generate

sqlc.generate:
	sqlc generate

dbmate.new:
	dbmate --url $(DATABASE_URL) new $(name)

dbmate.up:
	dbmate --url $(DATABASE_URL) --no-dump-schema up

dbmate.down:
	dbmate --url $(DATABASE_URL) --no-dump-schema down

dbmate.status:
	dbmate --url $(DATABASE_URL) status

