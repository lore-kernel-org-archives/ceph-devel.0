From: <mike.otoole@outlook.com>
Subject: Re: [ceph-users] radosgw-admin unable to list or store user info
 after upgrade
Date: Thu, 26 Sep 2013 18:07:34 -0400
Message-ID: <COL401-EAS84BAF74C69F80AA0CE460AEA280@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from col0-omc3-s14.col0.hotmail.com ([65.55.34.152]:33764 "EHLO
	col0-omc3-s14.col0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754420Ab3IZWNq convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Sep 2013 18:13:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks, it appears I missed that step on that host. Shouldn't the ceph deply utility take care of that step?

--- Original Message ---

From: "Yehuda Sadeh" <yehuda@inktank.com>
Sent: September 26, 2013 3:08 PM
To: "Mike O'Toole" <mike.otoole@outlook.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Subject: Re: [ceph-users] radosgw-admin unable to list or store user info after upgrade

There's a mismatch between the installed objclasses to the osd
run-time environment. Did you restart the osds after the upgrade?

On Thu, Sep 26, 2013 at 11:03 AM, Mike O'Toole <mike.otoole@outlook.com> wrote:
>
> OK, looks like here is the error.
>
> 2013-09-26 13:25:13.955291 7f6e46fb4700  0 _load_class could not open class
> /usr/lib/rados-classes/libcls_version.so (dlopen failed):
> /usr/lib/rados-classes/libcls_version.so: undefined symbol:
> _Z19cls_gen_rand_base64Pci
> 2013-09-26 13:25:13.960017 7f6e46fb4700  0 _load_class could not open class
> /usr/lib/rados-classes/libcls_version.so (dlopen failed):
> /usr/lib/rados-classes/libcls_version.so: undefined symbol:
> _Z19cls_gen_rand_base64Pci
>
>
>> Date: Thu, 26 Sep 2013 10:47:01 -0700
>
>> Subject: Re: [ceph-users] radosgw-admin unable to list or store user info
>> after upgrade
>> From: yehuda@inktank.com
>> To: mike.otoole@outlook.com; ceph-users@lists.ceph.com
>>
>> The osd returns some unexpected error:
>>
>> 2013-09-26 13:25:17.651552 7ff13cd0b700 1 -- 10.10.2.55:0/1005496 <==
>> osd.2 10.10.2.200:6800/4790 5 ==== osd_op_reply(25 bob
>> [call,getxattrs,stat] ack = -5 (Input/output error)) v4 ==== 186+0+0
>> (4137529543 0 0) 0x7ff120002490 con 0xa6a380
>>
>> Is there a matching osd log for that? I'd need to have the osd.2 log
>> for that (if specifying the admin2 user).
>>
>> On Thu, Sep 26, 2013 at 10:29 AM, Mike O'Toole <mike.otoole@outlook.com>
>> wrote:
>> > I thought that command would return a list of users. I get the same
>> > issue
>> > when I supply a --uid
>> >
>> > Here are two attached test cases.
>> >
>> > 1. (User Info) radosgw-admin user info --uid=admin2 --debug-ms=1 and
>> > --debug-rgw=20 --debug-objecter=20 &> $HOME/radosgw_admin2_user_info.out
>> > 2. (User Create) radosgw-admin user create --uid=bob
>> > --display-name="Bob"
>> > --debug-ms=1 and --debug-rgw=20 --debug-objecter=20 &>
>> > $HOME/radosgw_user_create.out
>> >
>> >
>> >> Date: Thu, 26 Sep 2013 10:02:51 -0700
>> >
>> >> Subject: Re: [ceph-users] radosgw-admin unable to list or store user
>> >> info
>> >> after upgrade
>> >> From: yehuda@inktank.com
>> >> To: mike.otoole@outlook.com; ceph-devel@vger.kernel.org
>> >>
>> >> On Thu, Sep 26, 2013 at 9:41 AM, Mike O'Toole <mike.otoole@outlook.com>
>> >> wrote:
>> >> > Sure,
>> >> >
>> >> > I issued: radosgw-admin user info --debug-ms=1 and --debug-rgw=20
>> >> > --debug-objecter=20 &> $HOME/radosgw_user_info.out
>> >>
>> >> You missed --uid=bob here. The error message is a bit confusing but
>> >> this is expected.
>> >>
>> >> >
>> >> > log info attached.
>> >> >
>> >> >
>> >> >> Date: Thu, 26 Sep 2013 09:34:45 -0700
>> >> >
>> >> >> Subject: Re: [ceph-users] radosgw-admin unable to list or store user
>> >> >> info
>> >> >> after upgrade
>> >> >> From: yehuda@inktank.com
>> >> >> To: mike.otoole@outlook.com; ceph-users@lists.ceph.com
>> >> >
>> >> >>
>> >> >> Are you sure you ran the same radosgw-admin command? the log shows a
>> >> >> different error message. Can you re-run it with also (besides the
>> >> >> --debug-ms=1 and --debug-rgw=20) also with --debug-objecter=20?
>> >> >>
>> >> >> On Thu, Sep 26, 2013 at 9:09 AM, Mike O'Toole
>> >> >> <mike.otoole@outlook.com>
>> >> >> wrote:
>> >> >> > radosgw-admin zone get
>> >> >> > { "domain_root": ".rgw",
>> >> >> > "control_pool": ".rgw.control",
>> >> >> > "gc_pool": ".rgw.gc",
>> >> >> > "log_pool": ".log",
>> >> >> > "intent_log_pool": ".intent-log",
>> >> >> > "usage_log_pool": ".usage",
>> >> >> > "user_keys_pool": ".users",
>> >> >> > "user_email_pool": ".users.email",
>> >> >> > "user_swift_pool": ".users.swift",
>> >> >> > "user_uid_pool": ".users.uid",
>> >> >> > "system_key": { "access_key": "",
>> >> >> > "secret_key": ""},
>> >> >> > "placement_pools": []}
>> >> >> >
>> >> >> > rados lspools
>> >> >> > data
>> >> >> > metadata
>> >> >> > rbd
>> >> >> > .rgw
>> >> >> > .rgw.gc
>> >> >> > .rgw.control
>> >> >> > .users.uid
>> >> >> > .users
>> >> >> > .users.email
>> >> >> > .rgw.buckets
>> >> >> > .log
>> >> >> > .usage
>> >> >> > .rgw.root
>> >> >> >
>> >> >> >
>> >> >> >> Date: Thu, 26 Sep 2013 09:05:08 -0700
>> >> >> >
>> >> >> >> Subject: Re: [ceph-users] radosgw-admin unable to list or store
>> >> >> >> user
>> >> >> >> info
>> >> >> >> after upgrade
>> >> >> >> From: yehuda@inktank.com
>> >> >> >> To: mike.otoole@outlook.com; ceph-devel@vger.kernel.org
>> >> >> >
>> >> >> >>
>> >> >> >> What do the following return?
>> >> >> >>
>> >> >> >> $ radosgw-admin zone get
>> >> >> >>
>> >> >> >> $ rados lspools
>> >> >> >>
>> >> >> >>
>> >> >> >>
>> >> >> >> On Thu, Sep 26, 2013 at 8:13 AM, Mike O'Toole
>> >> >> >> <mike.otoole@outlook.com>
>> >> >> >> wrote:
>> >> >> >> > Coming through the admin ops rest inteface I get the following
>> >> >> >> > log
>> >> >> >> > info:
>> >> >> >> > ET
>> >> >> >> >
>> >> >> >> > application/x-www-form-urlencoded; charset=utf-8
>> >> >> >> > Thu, 26 Sep 2013 15:08:34 GMT
>> >> >> >> > /admin/user
>> >> >> >> > 2013-09-26 11:08:34.449849 7ffbe67dc700 15 calculated
>> >> >> >> > digest=5vI0b/Ytn+XaSehRsqRu5PmNUBc=
>> >> >> >> > 2013-09-26 11:08:34.449854 7ffbe67dc700 15
>> >> >> >> > auth_sign=5vI0b/Ytn+XaSehRsqRu5PmNUBc=
>> >> >> >> > 2013-09-26 11:08:34.449855 7ffbe67dc700 15 compare=0
>> >> >> >> > 2013-09-26 11:08:34.449861 7ffbe67dc700 2 req 2:0.008683::GET
>> >> >> >> > /admin/user:get_user_info:reading permissions
>> >> >> >> > 2013-09-26 11:08:34.449867 7ffbe67dc700 2 req 2:0.008690::GET
>> >> >> >> > /admin/user:get_user_info:verifying op mask
>> >> >> >> > 2013-09-26 11:08:34.449871 7ffbe67dc700 20 required_mask= 0
>> >> >> >> > user.op_mask=7
>> >> >> >> > 2013-09-26 11:08:34.449873 7ffbe67dc700 2 req 2:0.008696::GET
>> >> >> >> > /admin/user:get_user_info:verifying op permissions
>> >> >> >> > 2013-09-26 11:08:34.449878 7ffbe67dc700 2 req 2:0.008701::GET
>> >> >> >> > /admin/user:get_user_info:verifying op params
>> >> >> >> > 2013-09-26 11:08:34.449881 7ffbe67dc700 2 req 2:0.008704::GET
>> >> >> >> > /admin/user:get_user_info:executing
>> >> >> >> > 2013-09-26 11:08:34.449916 7ffbe67dc700 20 get_obj_state:
>> >> >> >> > rctx=0x7ffc0c008ad0 obj=.users.uid:admin2 state=0x7ffc0c008b98
>> >> >> >> > s->prefetch_data=0
>> >> >> >> > 2013-09-26 11:08:34.449927 7ffbe67dc700 10 moving
>> >> >> >> > .users.uid+admin2
>> >> >> >> > to
>> >> >> >> > cache
>> >> >> >> > LRU end
>> >> >> >> > 2013-09-26 11:08:34.449930 7ffbe67dc700 10 cache get:
>> >> >> >> > name=.users.uid+admin2
>> >> >> >> > : type miss (requested=22, cached=7)
>> >> >> >> > 2013-09-26 11:08:34.451617 7ffbe67dc700 2 req 2:0.010439::GET
>> >> >> >> > /admin/user:get_user_info:http status=404
>> >> >> >> >
>> >> >> >> > Ive attached the log generated by the radosgw-admin user info
>> >> >> >> > command
>> >> >> >> >
>> >> >> >> >
>> >> >> >> >> Date: Thu, 26 Sep 2013 07:51:42 -0700
>> >> >> >> >> Subject: Re: [ceph-users] radosgw-admin unable to list or
>> >> >> >> >> store
>> >> >> >> >> user
>> >> >> >> >> info
>> >> >> >> >> after upgrade
>> >> >> >> >> From: yehuda@inktank.com
>> >> >> >> >> To: mike.otoole@outlook.com
>> >> >> >> >> CC: ceph-users@ceph.com
>> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> On Thu, Sep 26, 2013 at 7:42 AM, Mike O'Toole
>> >> >> >> >> <mike.otoole@outlook.com>
>> >> >> >> >> wrote:
>> >> >> >> >> > After upgrading from Cuddlefish to Dumpling I am no longer
>> >> >> >> >> > able
>> >> >> >> >> > to
>> >> >> >> >> > obtain
>> >> >> >> >> > user information from the rados gateway.
>> >> >> >> >> >
>> >> >> >> >> > radosgw-admin user info
>> >> >> >> >> > could not fetch user info: no user info saved
>> >> >> >> >> >
>> >> >> >> >> >
>> >> >> >> >> > radosgw-admin user create --uid=bob --display-name="bob"
>> >> >> >> >> > could not create user: unable to create user, unable to
>> >> >> >> >> > store
>> >> >> >> >> > user
>> >> >> >> >> > info
>> >> >> >> >>
>> >> >> >> >> What does the gateway log show? Try running the same command
>> >> >> >> >> with
>> >> >> >> >> --debug-rgw=20 --debug-ms=1 --log-to-stderr
>> >> >> >> >>
>> >> >> >> >> Yehuda
