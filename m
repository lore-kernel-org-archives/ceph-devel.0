From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [ceph-users] radosgw-admin unable to list or store user info
 after upgrade
Date: Thu, 26 Sep 2013 10:02:51 -0700
Message-ID: <CABBk=J9iDcrK+TGVn4hAPRD3=vTfxHgA8rkBSDY7uC8vNJGYxQ@mail.gmail.com>
References: <COL127-W34D4DAB91223FFC16BB19AEA280@phx.gbl>
	<CABBk=J84Kn0UckHuoUBzG74_8aq0Ypw3TVR+_cEJd6x2pzb+zw@mail.gmail.com>
	<COL127-W26197D457BE7EDC96D2D52EA280@phx.gbl>
	<CABBk=J8qaRE_ukaeoE27JaLWi5j2AC1LZjowcqKYRiv+hKNeZg@mail.gmail.com>
	<COL127-W34AD6465595C4C58FF4555EA280@phx.gbl>
	<CABBk=J_d_R2-SRMSFqPCUQyfE1cjRMhvzZmVDLUe8mc9WhEq=Q@mail.gmail.com>
	<COL127-W456670A24CA4604718E456EA280@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:47200 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3IZRCw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 13:02:52 -0400
Received: by mail-vb0-f48.google.com with SMTP id w16so1043024vbf.7
        for <ceph-devel@vger.kernel.org>; Thu, 26 Sep 2013 10:02:51 -0700 (PDT)
In-Reply-To: <COL127-W456670A24CA4604718E456EA280@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike O'Toole <mike.otoole@outlook.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 26, 2013 at 9:41 AM, Mike O'Toole <mike.otoole@outlook.com> wrote:
> Sure,
>
> I issued: radosgw-admin user info --debug-ms=1 and --debug-rgw=20
> --debug-objecter=20 &> $HOME/radosgw_user_info.out

You missed --uid=bob here. The error message is a bit confusing but
this is expected.

>
> log info attached.
>
>
>> Date: Thu, 26 Sep 2013 09:34:45 -0700
>
>> Subject: Re: [ceph-users] radosgw-admin unable to list or store user info
>> after upgrade
>> From: yehuda@inktank.com
>> To: mike.otoole@outlook.com; ceph-users@lists.ceph.com
>
>>
>> Are you sure you ran the same radosgw-admin command? the log shows a
>> different error message. Can you re-run it with also (besides the
>> --debug-ms=1 and --debug-rgw=20) also with --debug-objecter=20?
>>
>> On Thu, Sep 26, 2013 at 9:09 AM, Mike O'Toole <mike.otoole@outlook.com>
>> wrote:
>> > radosgw-admin zone get
>> > { "domain_root": ".rgw",
>> > "control_pool": ".rgw.control",
>> > "gc_pool": ".rgw.gc",
>> > "log_pool": ".log",
>> > "intent_log_pool": ".intent-log",
>> > "usage_log_pool": ".usage",
>> > "user_keys_pool": ".users",
>> > "user_email_pool": ".users.email",
>> > "user_swift_pool": ".users.swift",
>> > "user_uid_pool": ".users.uid",
>> > "system_key": { "access_key": "",
>> > "secret_key": ""},
>> > "placement_pools": []}
>> >
>> > rados lspools
>> > data
>> > metadata
>> > rbd
>> > .rgw
>> > .rgw.gc
>> > .rgw.control
>> > .users.uid
>> > .users
>> > .users.email
>> > .rgw.buckets
>> > .log
>> > .usage
>> > .rgw.root
>> >
>> >
>> >> Date: Thu, 26 Sep 2013 09:05:08 -0700
>> >
>> >> Subject: Re: [ceph-users] radosgw-admin unable to list or store user
>> >> info
>> >> after upgrade
>> >> From: yehuda@inktank.com
>> >> To: mike.otoole@outlook.com; ceph-devel@vger.kernel.org
>> >
>> >>
>> >> What do the following return?
>> >>
>> >> $ radosgw-admin zone get
>> >>
>> >> $ rados lspools
>> >>
>> >>
>> >>
>> >> On Thu, Sep 26, 2013 at 8:13 AM, Mike O'Toole <mike.otoole@outlook.com>
>> >> wrote:
>> >> > Coming through the admin ops rest inteface I get the following log
>> >> > info:
>> >> > ET
>> >> >
>> >> > application/x-www-form-urlencoded; charset=utf-8
>> >> > Thu, 26 Sep 2013 15:08:34 GMT
>> >> > /admin/user
>> >> > 2013-09-26 11:08:34.449849 7ffbe67dc700 15 calculated
>> >> > digest=5vI0b/Ytn+XaSehRsqRu5PmNUBc=
>> >> > 2013-09-26 11:08:34.449854 7ffbe67dc700 15
>> >> > auth_sign=5vI0b/Ytn+XaSehRsqRu5PmNUBc=
>> >> > 2013-09-26 11:08:34.449855 7ffbe67dc700 15 compare=0
>> >> > 2013-09-26 11:08:34.449861 7ffbe67dc700 2 req 2:0.008683::GET
>> >> > /admin/user:get_user_info:reading permissions
>> >> > 2013-09-26 11:08:34.449867 7ffbe67dc700 2 req 2:0.008690::GET
>> >> > /admin/user:get_user_info:verifying op mask
>> >> > 2013-09-26 11:08:34.449871 7ffbe67dc700 20 required_mask= 0
>> >> > user.op_mask=7
>> >> > 2013-09-26 11:08:34.449873 7ffbe67dc700 2 req 2:0.008696::GET
>> >> > /admin/user:get_user_info:verifying op permissions
>> >> > 2013-09-26 11:08:34.449878 7ffbe67dc700 2 req 2:0.008701::GET
>> >> > /admin/user:get_user_info:verifying op params
>> >> > 2013-09-26 11:08:34.449881 7ffbe67dc700 2 req 2:0.008704::GET
>> >> > /admin/user:get_user_info:executing
>> >> > 2013-09-26 11:08:34.449916 7ffbe67dc700 20 get_obj_state:
>> >> > rctx=0x7ffc0c008ad0 obj=.users.uid:admin2 state=0x7ffc0c008b98
>> >> > s->prefetch_data=0
>> >> > 2013-09-26 11:08:34.449927 7ffbe67dc700 10 moving .users.uid+admin2
>> >> > to
>> >> > cache
>> >> > LRU end
>> >> > 2013-09-26 11:08:34.449930 7ffbe67dc700 10 cache get:
>> >> > name=.users.uid+admin2
>> >> > : type miss (requested=22, cached=7)
>> >> > 2013-09-26 11:08:34.451617 7ffbe67dc700 2 req 2:0.010439::GET
>> >> > /admin/user:get_user_info:http status=404
>> >> >
>> >> > Ive attached the log generated by the radosgw-admin user info command
>> >> >
>> >> >
>> >> >> Date: Thu, 26 Sep 2013 07:51:42 -0700
>> >> >> Subject: Re: [ceph-users] radosgw-admin unable to list or store user
>> >> >> info
>> >> >> after upgrade
>> >> >> From: yehuda@inktank.com
>> >> >> To: mike.otoole@outlook.com
>> >> >> CC: ceph-users@ceph.com
>> >> >
>> >> >>
>> >> >> On Thu, Sep 26, 2013 at 7:42 AM, Mike O'Toole
>> >> >> <mike.otoole@outlook.com>
>> >> >> wrote:
>> >> >> > After upgrading from Cuddlefish to Dumpling I am no longer able to
>> >> >> > obtain
>> >> >> > user information from the rados gateway.
>> >> >> >
>> >> >> > radosgw-admin user info
>> >> >> > could not fetch user info: no user info saved
>> >> >> >
>> >> >> >
>> >> >> > radosgw-admin user create --uid=bob --display-name="bob"
>> >> >> > could not create user: unable to create user, unable to store user
>> >> >> > info
>> >> >>
>> >> >> What does the gateway log show? Try running the same command with
>> >> >> --debug-rgw=20 --debug-ms=1 --log-to-stderr
>> >> >>
>> >> >> Yehuda
