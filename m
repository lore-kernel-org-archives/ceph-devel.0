From: Wade Holler <wade.holler@gmail.com>
Subject: ceph osd tree and crushmap output wrong
Date: Fri, 8 Jan 2016 09:20:23 -0500
Message-ID: <CA+e22ScSuDNWFt2Z2hRyNhR1=-ovjvFfLyov06hWtjsX2V=FHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38359 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648AbcAHOUY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jan 2016 09:20:24 -0500
Received: by mail-ig0-f169.google.com with SMTP id mw1so74559438igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jan 2016 06:20:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,


I stay on the ceph-users list but haven't had any luck there with this.


Following is the pertinent parts of the thread. Sorry for all the text
but someones going to ask for it I'm sure....


------ Orig question

Sometimes my ceph osd tree output is wrong. Ie. Wrong osds on the
wrong hosts ?


Anyone else have this issue?


I have seen this at Infernalis and Jewell.


Thanks

Wade

-------- update on start false not set

[root@cpn00001 ~]# ceph daemon osd.0 config show | grep update | grep crush

[root@cpn00001 ~]# grep update /etc/ceph/ceph.conf

[root@cpn00001 ~]#

------- examples of output of tree command and crushmap

Sure.  Apologies for all the text: We have 12 Nodes for OSDs, 15 OSDs
per node,  but I will only include a sample:


ceph osd tree | head -35

ID  WEIGHT    TYPE NAME         UP/DOWN REWEIGHT PRIMARY-AFFINITY

 -1 130.98450 root default

 -2   5.82153     host cpn00001

  4   0.72769         osd.4          up  1.00000          1.00000

 14   0.72769         osd.14         up  1.00000          1.00000

  3   0.72769         osd.3          up  1.00000          1.00000

 24   0.72769         osd.24         up  1.00000          1.00000

  5   0.72769         osd.5          up  1.00000          1.00000

  2   0.72769         osd.2          up  1.00000          1.00000

 17   0.72769         osd.17         up  1.00000          1.00000

 69   0.72769         osd.69         up  1.00000          1.00000

 -3   6.54922     host cpn00003

  7   0.72769         osd.7          up  1.00000          1.00000

  8   0.72769         osd.8          up  1.00000          1.00000

  9   0.72769         osd.9          up  1.00000          1.00000

  0   0.72769         osd.0          up  1.00000          1.00000

 28   0.72769         osd.28         up  1.00000          1.00000

 10   0.72769         osd.10         up  1.00000          1.00000

  1   0.72769         osd.1          up  1.00000          1.00000

  6   0.72769         osd.6          up  1.00000          1.00000

 29   0.72769         osd.29         up  1.00000          1.00000

 -4   2.91077     host cpn00004

Compared with the actual processes that are running:


[root@cpx00001 ~]# ssh cpn00001 ps -ef | grep ceph\-osd

ceph       92638       1 26 16:19 ?        01:00:55 /usr/bin/ceph-osd
-f --cluster ceph --id 6 --setuser ceph --setgroup ceph

ceph       92667       1 20 16:19 ?        00:48:04 /usr/bin/ceph-osd
-f --cluster ceph --id 0 --setuser ceph --setgroup ceph

ceph       92673       1 18 16:19 ?        00:42:48 /usr/bin/ceph-osd
-f --cluster ceph --id 8 --setuser ceph --setgroup ceph

ceph       92681       1 19 16:19 ?        00:45:52 /usr/bin/ceph-osd
-f --cluster ceph --id 7 --setuser ceph --setgroup ceph

ceph       92701       1 15 16:19 ?        00:36:05 /usr/bin/ceph-osd
-f --cluster ceph --id 12 --setuser ceph --setgroup ceph

ceph       92748       1 14 16:19 ?        00:34:07 /usr/bin/ceph-osd
-f --cluster ceph --id 10 --setuser ceph --setgroup ceph

ceph       92756       1 16 16:19 ?        00:38:40 /usr/bin/ceph-osd
-f --cluster ceph --id 9 --setuser ceph --setgroup ceph

ceph       92758       1 17 16:19 ?        00:39:28 /usr/bin/ceph-osd
-f --cluster ceph --id 13 --setuser ceph --setgroup ceph

ceph       92777       1 19 16:19 ?        00:46:17 /usr/bin/ceph-osd
-f --cluster ceph --id 1 --setuser ceph --setgroup ceph

ceph       92988       1 18 16:19 ?        00:42:47 /usr/bin/ceph-osd
-f --cluster ceph --id 5 --setuser ceph --setgroup ceph

ceph       93058       1 18 16:19 ?        00:43:18 /usr/bin/ceph-osd
-f --cluster ceph --id 11 --setuser ceph --setgroup ceph

ceph       93078       1 17 16:19 ?        00:41:38 /usr/bin/ceph-osd
-f --cluster ceph --id 14 --setuser ceph --setgroup ceph

ceph       93127       1 15 16:19 ?        00:36:29 /usr/bin/ceph-osd
-f --cluster ceph --id 4 --setuser ceph --setgroup ceph

ceph       93130       1 17 16:19 ?        00:40:44 /usr/bin/ceph-osd
-f --cluster ceph --id 2 --setuser ceph --setgroup ceph

ceph       93173       1 21 16:19 ?        00:49:37 /usr/bin/ceph-osd
-f --cluster ceph --id 3 --setuser ceph --setgroup ceph

[root@cpx00001 ~]# ssh cpn00003 ps -ef | grep ceph\-osd

ceph       82454       1 18 16:19 ?        00:43:58 /usr/bin/ceph-osd
-f --cluster ceph --id 25 --setuser ceph --setgroup ceph

ceph       82464       1 24 16:19 ?        00:55:40 /usr/bin/ceph-osd
-f --cluster ceph --id 21 --setuser ceph --setgroup ceph

ceph       82473       1 21 16:19 ?        00:50:14 /usr/bin/ceph-osd
-f --cluster ceph --id 17 --setuser ceph --setgroup ceph

ceph       82612       1 19 16:19 ?        00:45:25 /usr/bin/ceph-osd
-f --cluster ceph --id 22 --setuser ceph --setgroup ceph

ceph       82629       1 20 16:19 ?        00:48:38 /usr/bin/ceph-osd
-f --cluster ceph --id 16 --setuser ceph --setgroup ceph

ceph       82651       1 16 16:19 ?        00:39:24 /usr/bin/ceph-osd
-f --cluster ceph --id 20 --setuser ceph --setgroup ceph

ceph       82687       1 17 16:19 ?        00:40:31 /usr/bin/ceph-osd
-f --cluster ceph --id 18 --setuser ceph --setgroup ceph

ceph       82697       1 26 16:19 ?        01:02:12 /usr/bin/ceph-osd
-f --cluster ceph --id 23 --setuser ceph --setgroup ceph

ceph       82719       1 20 16:19 ?        00:47:15 /usr/bin/ceph-osd
-f --cluster ceph --id 15 --setuser ceph --setgroup ceph

ceph       82722       1 14 16:19 ?        00:33:41 /usr/bin/ceph-osd
-f --cluster ceph --id 28 --setuser ceph --setgroup ceph

ceph       82725       1 14 16:19 ?        00:33:16 /usr/bin/ceph-osd
-f --cluster ceph --id 26 --setuser ceph --setgroup ceph

ceph       82743       1 14 16:19 ?        00:34:17 /usr/bin/ceph-osd
-f --cluster ceph --id 29 --setuser ceph --setgroup ceph

ceph       82769       1 19 16:19 ?        00:46:00 /usr/bin/ceph-osd
-f --cluster ceph --id 19 --setuser ceph --setgroup ceph

ceph       82816       1 13 16:19 ?        00:30:26 /usr/bin/ceph-osd
-f --cluster ceph --id 27 --setuser ceph --setgroup ceph

ceph       82828       1 27 16:19 ?        01:04:38 /usr/bin/ceph-osd
-f --cluster ceph --id 24 --setuser ceph --setgroup ceph


[root@cpx00001 ~]#

Looks like the crushmap is bad also:

(Cluster appears to be operating ok but this really concerns me.)

# begin crush map

tunable choose_local_tries 0

tunable choose_local_fallback_tries 0

tunable choose_total_tries 50

tunable chooseleaf_descend_once 1

tunable straw_calc_version 1


# devices

device 0 osd.0

device 1 osd.1

device 2 osd.2

device 3 osd.3

device 4 osd.4

device 5 osd.5

device 6 osd.6

device 7 osd.7

device 8 osd.8

device 9 osd.9

device 10 osd.10

device 11 osd.11

device 12 osd.12

device 13 osd.13

device 14 osd.14

device 15 osd.15

device 16 osd.16

device 17 osd.17

device 18 osd.18

device 19 osd.19

device 20 osd.20

device 21 osd.21

device 22 osd.22

device 23 osd.23

device 24 osd.24

device 25 osd.25

device 26 osd.26

device 27 osd.27

device 28 osd.28

device 29 osd.29

device 30 osd.30

device 31 osd.31

device 32 osd.32

device 33 osd.33

device 34 osd.34

device 35 osd.35

device 36 osd.36


device 37 osd.37

...


# types

type 0 osd

type 1 host

type 2 chassis

type 3 rack

type 4 row

type 5 pdu

type 6 pod

type 7 room

type 8 datacenter

type 9 region

type 10 root


# buckets

host cpn00001 {

        id -2           # do not change unnecessarily

        # weight 5.822

        alg straw

        hash 0  # rjenkins1

        item osd.4 weight 0.728

        item osd.14 weight 0.728

        item osd.3 weight 0.728

        item osd.24 weight 0.728

        item osd.5 weight 0.728

        item osd.2 weight 0.728

        item osd.17 weight 0.728

        item osd.69 weight 0.728

}

host cpn00003 {

        id -3           # do not change unnecessarily

        # weight 6.549

        alg straw

        hash 0  # rjenkins1

        item osd.7 weight 0.728

        item osd.8 weight 0.728

        item osd.9 weight 0.728

        item osd.0 weight 0.728

        item osd.28 weight 0.728

        item osd.10 weight 0.728

        item osd.1 weight 0.728

        item osd.6 weight 0.728

        item osd.29 weight 0.728

}


host cpn00004 {....



Thank you for your review !!!!!


-----

Any help would be greatly appreciated as this has me very concerned.
Otherwise the cluster appears very healthy and running well.


Thanks
