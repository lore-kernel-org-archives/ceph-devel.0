From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] Potential OSD deadlock?
Date: Tue, 22 Sep 2015 15:45:02 -0600
Message-ID: <CAANLjFqzzrAdJhx34ec5rbR5BTYpBJPO7w2SXvWmukgj4LuHiQ@mail.gmail.com>
References: <CAANLjFpAXaDWQzumg1hCs=SC_0YvdYDd6vyodz5_ZBNvGWdkSw@mail.gmail.com>
	<CAANLjFrbhiqjfUqiEPEOO+aZNTWwMEeTzZmro+OSrPmUg8AZLg@mail.gmail.com>
	<CAANLjFq=RpNygfSf2YsmtrpHiogHnAXqa=09jkwvHJkHb0Xyfw@mail.gmail.com>
	<CAANLjFob5ZsJzYop0RjQsXw-4UfV4OvdhBjT2sGF-u6gq9NrhQ@mail.gmail.com>
	<CAJ4mKGZ8WhY5JWD2P=5fQ+9EYQazEKETCTg8gU6qcZ03V3jrVw@mail.gmail.com>
	<CAANLjFrcx_M7BxW5UCZxUk_Y7-s3NneBevnP+JHU0PA8pazpAw@mail.gmail.com>
	<CAJ4mKGZLD4QfAfhZEXAe6KSbq9Z6wPXdUes_GJunfgnTf+K0Yg@mail.gmail.com>
	<CAANLjFqn8t+w3hACiCvgi2zpG4TGFYzmAW5ocsa1TOjqueY6QQ@mail.gmail.com>
	<CAJ4mKGY-XcFvbzSCRH4d5qJuwNE1uQ0Kdj7UCq5p0saFyaoiBA@mail.gmail.com>
	<CAANLjFrDqHhAtWPqBV+QEDcFU6xNum37puO6XHZE0zhNp9reSQ@mail.gmail.com>
	<CAJ4mKGYdJJfFERrOrdN7T8SzhdcyKhSDqJ69wOiee2aVj8vpEA@mail.gmail.com>
	<CAANLjFqbt0y-Ri=q6hXuuS06Sgi1S6phRdb1MJTgR6LTyHPtvw@mail.gmail.com>
	<CAN=+7FVo6D2AoufELCP_qeiJ23i0XEOqQs_yYLrFNXwiiQSthw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36447 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934154AbbIVVpE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 17:45:04 -0400
Received: by vkfp126 with SMTP id p126so15869401vkf.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2015 14:45:03 -0700 (PDT)
In-Reply-To: <CAN=+7FVo6D2AoufELCP_qeiJ23i0XEOqQs_yYLrFNXwiiQSthw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "Weil, Sage" <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

4.2.0-1.el7.elrepo.x86_64
- - ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Tue, Sep 22, 2015 at 3:41 PM, Samuel Just  wrote:
> I looked at the logs, it looks like there was a 53 second delay
> between when osd.17 started sending the osd_repop message and when
> osd.13 started reading it, which is pretty weird.  Sage, didn't we
> once see a kernel issue which caused some messages to be mysteriously
> delayed for many 10s of seconds?
>
> What kernel are you running?
> -Sam
>
> On Tue, Sep 22, 2015 at 2:22 PM, Robert LeBlanc  wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> OK, looping in ceph-devel to see if I can get some more eyes. I've
>> extracted what I think are important entries from the logs for the
>> first blocked request. NTP is running all the servers so the logs
>> should be close in terms of time. Logs for 12:50 to 13:00 are
>> available at http://162.144.87.113/files/ceph_block_io.logs.tar.xz
>>
>> 2015-09-22 12:55:06.500374 - osd.17 gets I/O from client
>> 2015-09-22 12:55:06.557160 - osd.17 submits I/O to osd.13
>> 2015-09-22 12:55:06.557305 - osd.17 submits I/O to osd.16
>> 2015-09-22 12:55:06.573711 - osd.16 gets I/O from osd.17
>> 2015-09-22 12:55:06.595716 - osd.17 gets ondisk result=0 from osd.16
>> 2015-09-22 12:55:06.640631 - osd.16 reports to osd.17 ondisk result=0
>> 2015-09-22 12:55:36.926691 - osd.17 reports slow I/O > 30.439150 sec
>> 2015-09-22 12:55:59.790591 - osd.13 gets I/O from osd.17
>> 2015-09-22 12:55:59.812405 - osd.17 gets ondisk result=0 from osd.13
>> 2015-09-22 12:56:02.941602 - osd.13 reports to osd.17 ondisk result=0
>>
>> In the logs I can see that osd.17 dispatches the I/O to osd.13 and
>> osd.16 almost silmutaniously. osd.16 seems to get the I/O right away,
>> but for some reason osd.13 doesn't get the message until 53 seconds
>> later. osd.17 seems happy to just wait and doesn't resend the data
>> (well, I'm not 100% sure how to tell which entries are the actual data
>> transfer).
>>
>> It looks like osd.17 is receiving responses to start the communication
>> with osd.13, but the op is not acknowledged until almost a minute
>> later. To me it seems that the message is getting received but not
>> passed to another thread right away or something. This test was done
>> with an idle cluster, a single fio client (rbd engine) with a single
>> thread.
>>
>> The OSD servers are almost 100% idle during these blocked I/O
>> requests. I think I'm at the end of my troubleshooting, so I can use
>> some help.
>>
>> Single Test started about
>> 2015-09-22 12:52:36
>>
>> 2015-09-22 12:55:36.926680 osd.17 192.168.55.14:6800/16726 56 :
>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
>> 30.439150 secs
>> 2015-09-22 12:55:36.926699 osd.17 192.168.55.14:6800/16726 57 :
>> cluster [WRN] slow request 30.439150 seconds old, received at
>> 2015-09-22 12:55:06.487451:
>>  osd_op(client.250874.0:1388 rbd_data.3380e2ae8944a.0000000000000545
>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> 0~4194304] 8.bbf3e8ff ack+ondisk+write+known_if_redirected e56785)
>>  currently waiting for subops from 13,16
>> 2015-09-22 12:55:36.697904 osd.16 192.168.55.13:6800/29410 7 : cluster
>> [WRN] 2 slow requests, 2 included below; oldest blocked for >
>> 30.379680 secs
>> 2015-09-22 12:55:36.697918 osd.16 192.168.55.13:6800/29410 8 : cluster
>> [WRN] slow request 30.291520 seconds old, received at 2015-09-22
>> 12:55:06.406303:
>>  osd_op(client.250874.0:1384 rbd_data.3380e2ae8944a.0000000000000541
>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> 0~4194304] 8.5fb2123f ack+ondisk+write+known_if_redirected e56785)
>>  currently waiting for subops from 13,17
>> 2015-09-22 12:55:36.697927 osd.16 192.168.55.13:6800/29410 9 : cluster
>> [WRN] slow request 30.379680 seconds old, received at 2015-09-22
>> 12:55:06.318144:
>>  osd_op(client.250874.0:1382 rbd_data.3380e2ae8944a.000000000000053f
>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> 0~4194304] 8.312e69ca ack+ondisk+write+known_if_redirected e56785)
>>  currently waiting for subops from 13,14
>> 2015-09-22 12:58:03.998275 osd.13 192.168.55.12:6804/4574 130 :
>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
>> 30.954212 secs
>> 2015-09-22 12:58:03.998286 osd.13 192.168.55.12:6804/4574 131 :
>> cluster [WRN] slow request 30.954212 seconds old, received at
>> 2015-09-22 12:57:33.044003:
>>  osd_op(client.250874.0:1873 rbd_data.3380e2ae8944a.000000000000070d
>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> 0~4194304] 8.e69870d4 ack+ondisk+write+known_if_redirected e56785)
>>  currently waiting for subops from 16,17
>> 2015-09-22 12:58:03.759826 osd.16 192.168.55.13:6800/29410 10 :
>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
>> 30.704367 secs
>> 2015-09-22 12:58:03.759840 osd.16 192.168.55.13:6800/29410 11 :
>> cluster [WRN] slow request 30.704367 seconds old, received at
>> 2015-09-22 12:57:33.055404:
>>  osd_op(client.250874.0:1874 rbd_data.3380e2ae8944a.000000000000070e
>> [set-alloc-hint object_size 4194304 write_size 4194304,write
>> 0~4194304] 8.f7635819 ack+ondisk+write+known_if_redirected e56785)
>>  currently waiting for subops from 13,17
>>
>> Server   IP addr              OSD
>> nodev  - 192.168.55.11 - 12
>> nodew  - 192.168.55.12 - 13
>> nodex  - 192.168.55.13 - 16
>> nodey  - 192.168.55.14 - 17
>> nodez  - 192.168.55.15 - 14
>> nodezz - 192.168.55.16 - 15
>>
>> fio job:
>> [rbd-test]
>> readwrite=write
>> blocksize=4M
>> #runtime=60
>> name=rbd-test
>> #readwrite=randwrite
>> #bssplit=4k/85:32k/11:512/3:1m/1,4k/89:32k/10:512k/1
>> #rwmixread=72
>> #norandommap
>> #size=1T
>> #blocksize=4k
>> ioengine=rbd
>> rbdname=test2
>> pool=rbd
>> clientname=admin
>> iodepth=8
>> #numjobs=4
>> #thread
>> #group_reporting
>> #time_based
>> #direct=1
>> #ramp_time=60
>>
>>
>> Thanks,
>> -----BEGIN PGP SIGNATURE-----
>> Version: Mailvelope v1.1.0
>> Comment: https://www.mailvelope.com
>>
>> wsFcBAEBCAAQBQJWAcaKCRDmVDuy+mK58QAAPMsQAKBnS94fwuw0OqpPU3/z
>> tL8Z6TVRxrNigf721+2ClIu4LIH71bupDc3DgrrysQmmqGuvEMn68spmasWu
>> h9I/CqqgRpHqe4lUVoUEjyWA9/6Dbb6NiHSdpJ6p5jpGc8kZCvNS+ocDgFOl
>> 903i0M0E9eEMeci5O/hrMrx1FG8SN2LS8nI261aNHMOwQK0bw8wWiCJEvqVB
>> sz1/+jK1BJoeIYfaT9HfUXBAvfo/W3tY/vj9KbJuZJ5AMpeYPvEHu/LAr1N7
>> FzzUc7a6EMlaxmSd0ML49JbV0cY9BMDjfrkKEQNKlzszlEHm3iif98QtsxbF
>> pPJ0hZ0G53BY3k976OWVMFm3WFRWUVOb/oiLF8H6PCm59b4LBNAg6iPNH1AI
>> 5XhEcPpg06M03vqUaIiY9P1kQlvnn0yCXf82IUEgmg///vhxDsHWmcwClLEn
>> B0VszouStTzlMYnc/2vlUiI4gFVeilWLMW00VGTWV+7V1oIzIYvWHyl2QpBq
>> 4/ZwVjQ43qLfuDTS4o+IJ4ztOMd26vIv6Mn6WVwKCjoCXJc8ajywR9Dy+6lL
>> o8oJ+tn7hMc9Qy1iBhu3/QIP4WCsUf9RVeu60oahNEpde89qW32S9CZlrJDO
>> gf4iTryRjkAhdmZIj9JiaE8jQ6dvN817D9cqs/CXKV9vhzYoM7p5YWHghBKB
>> J3hS
>> =0J7F
>> -----END PGP SIGNATURE-----
>> ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>
>>
>> On Tue, Sep 22, 2015 at 8:31 AM, Gregory Farnum  wrote:
>>> On Tue, Sep 22, 2015 at 7:24 AM, Robert LeBlanc  wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA256
>>>>
>>>> Is there some way to tell in the logs that this is happening?
>>>
>>> You can search for the (mangled) name _split_collection
>>>> I'm not
>>>> seeing much I/O, CPU usage during these times. Is there some way to
>>>> prevent the splitting? Is there a negative side effect to doing so?
>>>
>>> Bump up the split and merge thresholds. You can search the list for
>>> this, it was discussed not too long ago.
>>>
>>>> We've had I/O block for over 900 seconds and as soon as the sessions
>>>> are aborted, they are reestablished and complete immediately.
>>>>
>>>> The fio test is just a seq write, starting it over (rewriting from the
>>>> beginning) is still causing the issue. I was suspect that it is not
>>>> having to create new file and therefore split collections. This is on
>>>> my test cluster with no other load.
>>>
>>> Hmm, that does make it seem less likely if you're really not creating
>>> new objects, if you're actually running fio in such a way that it's
>>> not allocating new FS blocks (this is probably hard to set up?).
>>>
>>>>
>>>> I'll be doing a lot of testing today. Which log options and depths
>>>> would be the most helpful for tracking this issue down?
>>>
>>> If you want to go log diving "debug osd = 20", "debug filestore = 20",
>>> "debug ms = 1" are what the OSD guys like to see. That should spit out
>>> everything you need to track exactly what each Op is doing.
>>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- -----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.1.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWAcvUCRDmVDuy+mK58QAAlhIP/jZkxTpX72PSgd8OLTeY
OracWsDXiYpnlEZkm4G2N4Pev9B/dHuXYYmFf779ZQvUprbN09DuF2dQucZw
FpMZfrKbbXuMfLYKL/InNIt8g1lJltZMVt5SAKB+4PjNY1FJLLHjpCs7NV18
w+Vg05FKsD98kDGw6920TeFa08bHfCSF23AjopAlneqLtbYpn4Y/XgtOjuRB
03ATp4Iuk6rJphlzFrtoW33ccwwU2qbJvztSejoH5LPYpBPb7GF4AraBD8sn
ZSkJadufb4stWGS0cORd+2hy9Es5M+afRI0ifjCtwuysyLxWpCltoSHYOEhi
HVN7IhRKpal4PG1Ql+6+mWPmA2mjeIAJ9jr/Y1KvTQdezbTJO74wyKEAJwcV
z37MwppJ3KahXwIeqPP2foE0AmJqP/BBdRvzNj7Sp0rsdEVnEYbeNubqH11E
3BPRQVvW8hV6EfzbSDqGxSoDGUzCkqBlNxyj/kPis4DozUcFSAJ6yl5nZgld
e68NZXH9X54tOd+nAuPVSSmWigavPZcfYi5A5tF3zPKsK772Msi3PYF3FeYM
6Ipp0kwHAFYbLMYNxaGnYVOkQgwvgFwRXFkYcU7UrYkucIAud+/sO6uGqf6G
FDClJH2kPPYs+lsBr3rdr8a1RLGFaQtTTv69gJjUrCWjNSKtnZrKXIXX/pK1
cgT3
=7MQi
- -----END PGP SIGNATURE-----
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.1.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWAcvcCRDmVDuy+mK58QAAQIkQAJJneixj6eq9UuBHoVLA
ng7mzeTvBgLwgyHsDQVE6h/cC0ZKem8GYtZxyyVbeu6ex/dCeaxWgXqwXC4F
33XO7mdoVJDi6UHXIfRWOW0FFdZgG28VYC6Y0W5+n4HHC29MFxvxDOiMCx41
amobumpmzmZy87OoUMjd+vea1l56dsZaJfOhglQNUE/8cqrB0bXxU3lLlI+v
nb/kGZeUj1wELxq21fRV++RlfgQotSGNSv8e7Pgx/daCpvU5K1Aze/wJl7H7
uI1i3tz6f14wM4isk4ld6CWUyIc8C9EiUDdvj7XR06rF7E0aFDAm9OESr5Wz
wRkOAIQ7fypfYebKX/q9TS1R8SYgamEZNFGsZgz7k94oBV5C/wk926GdD3sR
RPZSlrw3KQMdjNt76gAQBKDnaAdE9mkEPxP6d/l+vTUVohBiOD2Ul8YL2PLv
la3LqtKIVU+7gneWTX3GNqHMHVHviQ75TihCHIVv/7+lePa9mIjwX53AKKwh
D5xrMESQZm6dLr1IZC28xqZofyFcBBwG4AkzS5nzu9S/tfoRh019ztLLNkA4
ddtZSDhDLRO0tnmSDsUsi1HBpqTXNNURkQYQh0cgXt4vQSMueej+5137qaCK
6RxvfcBVt/jV4eXUl91vLrcJpMjCO7p4ZDB2su7zruJuWhnLRQ0LETU6koZO
XEZe
=fkfd
-----END PGP SIGNATURE-----
