#!/bin/bash
mysql -uroot -p123456<<-EOF
select user,host from mysql.user;
	EOF
