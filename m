From: huang jun <hjwsm1989@gmail.com>
Subject: Re: Unable to mount CephFS
Date: Fri, 16 Oct 2015 11:36:45 +0800
Message-ID: <CABAwU-a5Uz_SaPYm4dWEDCicYPkZwMrxw7Mr-Cpof+FDADoAmA@mail.gmail.com>
References: <1444958943.32103.boukom.p.aa@m.titech.ac.jp>
	<CABAwU-YnKFhJSiehTuScEhJ12FbX+6x9QO9X_Bug_xacDQTKgQ@mail.gmail.com>
	<1444964191.24276.boukom.p.aa@m.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35889 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbbJPDgr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 23:36:47 -0400
Received: by lbcao8 with SMTP id ao8so89119708lbc.3
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 20:36:46 -0700 (PDT)
In-Reply-To: <1444964191.24276.boukom.p.aa@m.titech.ac.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "boukom.p.aa" <boukom.p.aa@m.titech.ac.jp>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

you mount with name=user, but there is no "client.user" in auth list,
what's  about mount with "name=admin"?

2015-10-16 10:56 GMT+08:00 boukom.p.aa <boukom.p.aa@m.titech.ac.jp>:
> Could you explain more about it ? What is it supposed to be ?
>
> This is my output of 'ceph auth list'
>
> mds.rc010
>     key: AQCrcxZWPVj9GBAANaJskP61dEYHFwDTCojdDg==
>     caps: [mds] allow
>     caps: [mon] allow profile mds
>     caps: [osd] allow rwx
> mds.rc012
>     key: AQCDjxZWUBiOEBAAY9sGZ++5oFfZ9Gp3Ym6dnQ==
>     caps: [mds] allow
>     caps: [mon] allow profile mds
>     caps: [osd] allow rwx
> mds.rc013
>     key: AQCEjxZW6RScJhAAru8yKObCv62ncMxGkKsxTA==
>     caps: [mds] allow
>     caps: [mon] allow profile mds
>     caps: [osd] allow rwx
> osd.0
>     key: AQC3kRNWtpBfKBAACmPcn5Bl7IfXb+1peceb2A==
>     caps: [mon] allow profile osd
>     caps: [osd] allow *
> osd.1
>     key: AQDBkRNWnY9wAhAAIFeYOKgK9m2VjtLCxq4JMw==
>     caps: [mon] allow profile osd
>     caps: [osd] allow *
> osd.2
>     key: AQDKkRNWPIzWGBAAN2cuf5XG2j00FDBzrgs2Vw==
>     caps: [mon] allow profile osd
>     caps: [osd] allow *
> osd.3
>     key: AQDTkRNWgelzLBAAp6GYr3ICJSnojcBLdgjaqg==
>     caps: [mon] allow profile osd
>     caps: [osd] allow *
> osd.4
>     key: AQDckRNW3VydORAALrw5Eal9ngxRsVxWZjFChg==
>     caps: [mon] allow profile osd
>     caps: [osd] allow *
> osd.5
>     key: AQDmkRNWkb0mDxAA2jykVfT7KmRmlwjKHqN7vw==
>     caps: [mon] allow profile osd
>     caps: [osd] allow *
> osd.6
>     key: AQDvkRNWmthEHxAAXPuvbvFU7dgKbhpWgIIbpg==
>     caps: [mon] allow profile osd
>     caps: [osd] allow *
> osd.7
>     key: AQD4kRNWCYIlDhAAD6sT1fzDEqz3X510VhjIyg==
>     caps: [mon] allow profile osd
>     caps: [osd] allow *
> client.admin
>     key: AQDnhBNW1kx3BBAAP3a0NTLmhS04OyiizeECcg==
>     caps: [mds] allow
>     caps: [mon] allow *
>     caps: [osd] allow *
> client.bootstrap-mds
>     key: AQDnhBNWBAMpLRAAX7XEnBbwjmO2iyvE+ngYoQ==
>     caps: [mon] allow profile bootstrap-mds
> client.bootstrap-osd
>     key: AQDnhBNWBeMRFBAA1BPn3EdKAEI3xenwxWS0Qw==
>     caps: [mon] allow profile bootstrap-osd
> client.bootstrap-rgw
>     key: AQDnhBNW+bq8IBAA0dob+3LNPcGSXu803BJ7lg==
>     caps: [mon] allow profile bootstrap-rgw
> client.rgw.rc012
>     key: AQAmjxZWdyxaIRAAXh+FfcAFogqmm93Y3voMoQ==
>     caps: [mon] allow rw
>     caps: [osd] allow rwx
>
> Regards,
> Piyawath
> -----Original message-----
> From:huang jun <hjwsm1989@gmail.com>
> To:boukom.p.aa <boukom.p.aa@m.titech.ac.jp>
> Cc:ceph-devel <ceph-devel@vger.kernel.org>
> Date:Fri, 16 Oct 2015 11:32:28
> Subject:Re: Unable to mount CephFS
>
> do you verified that 'user' have sufficient permission? use 'ceph auth
> list ' to check it.
>
> 2015-10-16 9:29 GMT+08:00 boukom.p.aa <boukom.p.aa@m.titech.ac.jp>:
>> Dear peoples in mailing-list,
>>
>> I've got a problem which is cannot mount CephFS.
>> This is my ceph status form 'ceph -s'
>>
>>     cluster 7e549325-246f-4265-8715-11591a26df79
>>      health HEALTH_OK
>>      monmap e3: 3 mons at {rc010=192.168.0.10:6789/0,rc012=192.168.0.12:6789/0,rc013=192.168.0.13:6789/0}
>>             election epoch 16, quorum 0,1,2 rc010,rc012,rc013
>>      mdsmap e13: 1/1/1 up {0=rc010=up:active}, 2 up:standby
>>      osdmap e625: 8 osds: 8 up, 8 in
>>       pgmap v4153: 200 pgs, 2 pools, 1962 bytes data, 20 objects
>>             106 GB used, 292 GB / 399 GB avail
>>                  200 active+clean
>>
>> Cluster seems to be ok, I guess.
>> I used the following command to mouth
>>
>> ~$ sudo mount -t ceph 192.168.0.10,192.168.12, 192.168.0.13:/ /mnt/mycephfs -o name=user,secretfile=/etc/ceph/key.secret
>>
>> key.secret(s) are in /etc/ceph of mon node(s)
>> The result is "mount error 1 = Operation not permitted"
>>
>> Any ideas for fixing this problem would be great.
>>
>> Regards,
>> Piyawath
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> thanks
> huangjun
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
thanks
huangjun
