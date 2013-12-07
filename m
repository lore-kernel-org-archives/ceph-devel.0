From: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: recreate bucket error
Date: Sat, 7 Dec 2013 09:34:15 -0800
Message-ID: <CABBk=J-RAb5dXZLU2F4heFu1VyoSnn9hxJ40_6UY8wXOOMBAdA@mail.gmail.com>
References: <CAMNMNTzt_yPoqOhgKpi9vioAXygzD_oKzhHxsh-WA6NCB7mOcg@mail.gmail.com>
	<CABBk=J95C7OrwTAPN_EJ8dHmTOiSFExhrAv2n5FJ6RyACuMETA@mail.gmail.com>
	<CAMNMNTzd7LEht6y-5vT6sEvJeG3yErQGNGbmGM3x+hYOuTQs0g@mail.gmail.com>
	<CAC-hyiG9hznbysGs84_etew3BTbZwj3QoHVP66QCbCK9asoPgw@mail.gmail.com>
	<CAMNMNTz4pANPK67m0mLhYS=-GQpvRQ7DWCsQMjORvoM+7NPXrw@mail.gmail.com>
	<CABBk=J8b_UU7YhJUMwWhc8wjkv0a+dD3GAWySajJF1MwzJp_Sw@mail.gmail.com>
	<CAMNMNTxqyutv2r5d_AXgMiNRr15qCipsirajqB8xLf=MuDY2Rg@mail.gmail.com>
	<CAMNMNTwvZbbpX1H0UZiRvFb4YY0h9VXvuJryPBE9tqE6O1rbvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTwvZbbpX1H0UZiRvFb4YY0h9VXvuJryPBE9tqE6O1rbvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Sounds like disabling the cache triggers some bug. I'll open a relevant ticket.

Thanks,
Yehuda

On Sat, Dec 7, 2013 at 9:29 AM, Dominik Mostowiec
<dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> ok, enabling cache helps :-)
> What was wrong ?
>
> --
> Dominik
>
> 2013/12/7 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Yes, it is disabled
>> grep 'cache' /etc/ceph/ceph.conf  | grep rgw
>>         rgw_cache_enabled = false ;rgw cache enabled
>>         rgw_cache_lru_size = 10000 ;num of entries in rgw cache
>>
>> --
>> Regards
>> Dominik
>>
>> 2013/12/7 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
>>> Did you disable the cache by any chance (e.g., 'rgw cache enabled = false')?
>>>
>>>
>>>
>>> On Sat, Dec 7, 2013 at 8:34 AM, Dominik Mostowiec
>>> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> Hi,
>>>> Log:
>>>> -------------------------
>>>> 2013-12-07 17:32:42.736396 7ffbe36d3780 10 allocated request req=0xe66f40
>>>> 2013-12-07 17:32:42.736438 7ff79b1c6700  1 ====== starting new request
>>>> req=0xe60860 =====
>>>> 2013-12-07 17:32:42.736590 7ff79b1c6700  2 req 1:0.000153::PUT
>>>> /test1/::initializing
>>>> 2013-12-07 17:32:42.736659 7ff79b1c6700 10 meta>> HTTP_X_AMZ_DATE
>>>> 2013-12-07 17:32:42.736686 7ff79b1c6700 10 x>> x-amz-date:Sat, 07 Dec
>>>> 2013 16:32:42 GMT
>>>> 2013-12-07 17:32:42.736758 7ff79b1c6700 10 s->object=<NULL> s->bucket=test1
>>>> 2013-12-07 17:32:42.736788 7ff79b1c6700  2 req 1:0.000351:s3:PUT
>>>> /test1/::getting op
>>>> 2013-12-07 17:32:42.736800 7ff79b1c6700  2 req 1:0.000364:s3:PUT
>>>> /test1/:create_bucket:authorizing
>>>> 2013-12-07 17:32:42.736907 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6804/161220 -- osd_op(client.95391.0:107
>>>> F7P3E755K6BN5LR3N85U [getxattrs,stat] 7.62531457 e192) v4 -- ?+0 0x7ff
>>>> 794005a90 con 0xd908d0
>>>> 2013-12-07 17:32:42.738159 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.1 10.174.33.11:6804/161220 23 ==== osd_op_reply(107
>>>> F7P3E755K6BN5LR3N85U [getxattrs,stat] ondisk = 0) v4 ==== 161+0+20 (
>>>> 1539386342 0 1044315090) 0x7ffba40019c0 con 0xd908d0
>>>> 2013-12-07 17:32:42.738341 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6804/161220 -- osd_op(client.95391.0:108
>>>> F7P3E755K6BN5LR3N85U [getxattrs,stat] 7.62531457 e192) v4 -- ?+0 0x7ff
>>>> 794005c20 con 0xd908d0
>>>> 2013-12-07 17:32:42.739230 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.1 10.174.33.11:6804/161220 24 ==== osd_op_reply(108
>>>> F7P3E755K6BN5LR3N85U [getxattrs,stat] ondisk = 0) v4 ==== 161+0+20 (
>>>> 1539386342 0 1044315090) 0x7ffba40019c0 con 0xd908d0
>>>> 2013-12-07 17:32:42.739349 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6804/161220 -- osd_op(client.95391.0:109
>>>> F7P3E755K6BN5LR3N85U [read 0~524288] 7.62531457 e192) v4 -- ?+0 0x7ff7
>>>> 94005a90 con 0xd908d0
>>>> 2013-12-07 17:32:42.740172 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.1 10.174.33.11:6804/161220 25 ==== osd_op_reply(109
>>>> F7P3E755K6BN5LR3N85U [read 0~5] ondisk = 0) v4 ==== 119+0+5 (9359852
>>>> 51 0 150087197) 0x7ffba40019c0 con 0xd908d0
>>>> 2013-12-07 17:32:42.740310 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:110 0
>>>> [getxattrs,stat] 6.f18a3536 e192) v4 -- ?+0 0x7ff794006570 con 0xd8b
>>>> 210
>>>> 2013-12-07 17:32:42.741208 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 49 ==== osd_op_reply(110 0
>>>> [getxattrs,stat] ondisk = 0) v4 ==== 142+0+91 (2507304458 0 349659
>>>> 2801) 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.741326 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:111 0
>>>> [getxattrs,stat] 6.f18a3536 e192) v4 -- ?+0 0x7ff7940063a0 con 0xd8b
>>>> 210
>>>> 2013-12-07 17:32:42.742153 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 50 ==== osd_op_reply(111 0
>>>> [getxattrs,stat] ondisk = 0) v4 ==== 142+0+91 (2507304458 0 349659
>>>> 2801) 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.742268 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:112 0 [read
>>>> 0~524288] 6.f18a3536 e192) v4 -- ?+0 0x7ff7940063a0 con 0xd8b2
>>>> 10
>>>> 2013-12-07 17:32:42.743159 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 51 ==== osd_op_reply(112 0 [read
>>>> 0~254] ondisk = 0) v4 ==== 100+0+254 (3890176355 0 345783013
>>>> 2) 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.743315 7ff79b1c6700 10 get_canon_resource(): dest=
>>>> 2013-12-07 17:32:42.743326 7ff79b1c6700 10 auth_hdr:
>>>> PUT
>>>>
>>>>
>>>>
>>>> x-amz-date:Sat, 07 Dec 2013 16:32:42 GMT
>>>> /test1/
>>>> 2013-12-07 17:32:42.743459 7ff79b1c6700  2 req 1:0.007023:s3:PUT
>>>> /test1/:create_bucket:reading permissions
>>>> 2013-12-07 17:32:42.743475 7ff79b1c6700  2 req 1:0.007038:s3:PUT
>>>> /test1/:create_bucket:verifying op mask
>>>> 2013-12-07 17:32:42.743479 7ff79b1c6700  2 req 1:0.007043:s3:PUT
>>>> /test1/:create_bucket:verifying op permissions
>>>> 2013-12-07 17:32:42.743542 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:113 0.buckets
>>>> [omap-get-vals 0~16] 6.f01626b7 e192) v4 -- ?+0 0x7ff7940066
>>>> 00 con 0xd8b210
>>>> 2013-12-07 17:32:42.744679 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 52 ==== osd_op_reply(113 0.buckets
>>>> [omap-get-vals 0~16] ondisk = 0) v4 ==== 108+0+288 (360462
>>>> 5994 0 2810901914) 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.744782 7ff79b1c6700  2 req 1:0.008346:s3:PUT
>>>> /test1/:create_bucket:verifying op params
>>>> 2013-12-07 17:32:42.744791 7ff79b1c6700  2 req 1:0.008355:s3:PUT
>>>> /test1/:create_bucket:executing
>>>> 2013-12-07 17:32:42.744895 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:114 test1 [call
>>>> version.read,getxattrs,stat] 4.bddbf0b9 e192) v4 -- ?+0 0x
>>>> 7ff7940083a0 con 0xd8b210
>>>> 2013-12-07 17:32:42.745873 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 53 ==== osd_op_reply(114 test1
>>>> [call,getxattrs,stat] ondisk = 0) v4 ==== 188+0+139 (2921607002 0
>>>> 1685432528) 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.746052 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:115 test1 [call
>>>> version.check_conds,call version.read,read 0~524288] 4.bddbf0b9 e192)
>>>> v4 -- ?+0 0x7ff794008d80 con 0xd8b210
>>>> 2013-12-07 17:32:42.746920 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 54 ==== osd_op_reply(115 test1
>>>> [call,call,read 0~111] ondisk = 0) v4 ==== 188+0+159 (3524501340 0
>>>> 3138215039) 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.747053 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.13:6800/296091 -- osd_op(client.95391.0:116
>>>> .bucket.meta.test1:default.78189.1 [call version.read,getxattrs,stat]
>>>> 4.50558ec5 e192) v4 -- ?+0 0x7ff794007390 con 0xd8f710
>>>> 2013-12-07 17:32:42.748661 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.24 10.174.33.13:6800/296091 19 ==== osd_op_reply(116
>>>> .bucket.meta.test1:default.78189.1 [call,getxattrs,stat] ondisk = 0)
>>>> v4 ==== 217+0+268 (1054813027 0 2886434386) 0x7ffbac0057b0 con
>>>> 0xd8f710
>>>> 2013-12-07 17:32:42.748815 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.13:6800/296091 -- osd_op(client.95391.0:117
>>>> .bucket.meta.test1:default.78189.1 [call version.check_conds,call
>>>> version.read,read 0~524288] 4.50558ec5 e192) v4 -- ?+0 0x7ff79400c050
>>>> con 0xd8f710
>>>> 2013-12-07 17:32:42.750149 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.24 10.174.33.13:6800/296091 20 ==== osd_op_reply(117
>>>> .bucket.meta.test1:default.78189.1 [call,call,read 0~147] ondisk = 0)
>>>> v4 ==== 217+0+195 (284787856 0 526624477) 0x7ffbac001f80 con 0xd8f710
>>>> 2013-12-07 17:32:42.750245 7ff79b1c6700  0 WARNING: couldn't find acl
>>>> header for object, generating default
>>>> 2013-12-07 17:32:42.750288 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:118 0
>>>> [getxattrs,stat] 6.f18a3536 e192) v4 -- ?+0 0x7ff794007670 con
>>>> 0xd8b210
>>>> 2013-12-07 17:32:42.751004 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 55 ==== osd_op_reply(118 0
>>>> [getxattrs,stat] ondisk = 0) v4 ==== 142+0+91 (2507304458 0
>>>> 3496592801) 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.751107 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:119 0
>>>> [getxattrs,stat] 6.f18a3536 e192) v4 -- ?+0 0x7ff794007650 con
>>>> 0xd8b210
>>>> 2013-12-07 17:32:42.751786 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 56 ==== osd_op_reply(119 0
>>>> [getxattrs,stat] ondisk = 0) v4 ==== 142+0+91 (2507304458 0
>>>> 3496592801) 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.751881 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:120 0 [read
>>>> 0~524288] 6.f18a3536 e192) v4 -- ?+0 0x7ff794007000 con 0xd8b210
>>>> 2013-12-07 17:32:42.752528 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 57 ==== osd_op_reply(120 0 [read
>>>> 0~254] ondisk = 0) v4 ==== 100+0+254 (3890176355 0 3457830132)
>>>> 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.752684 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6804/161220 -- osd_op(client.95391.0:121
>>>> .dir.default.95391.1 [create 0~0,call rgw.bucket_init_index]
>>>> 8.5a45c1c6 e192) v4 -- ?+0 0x7ff794007540 con 0xd908d0
>>>> 2013-12-07 17:32:42.756042 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.1 10.174.33.11:6804/161220 26 ==== osd_op_reply(121
>>>> .dir.default.95391.1 [create 0~0,call] ack = 0) v4 ==== 161+0+0
>>>> (905452886 0 0) 0x7ffba40019c0 con 0xd908d0
>>>> 2013-12-07 17:32:42.756314 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:122
>>>> .bucket.meta.test1:default.95391.1 [create 0~0,call
>>>> version.set,writefull 0~147,setxattr user.rgw.acl (109)] 4.e2d85709
>>>> e192) v4 -- ?+0 0x7ff794007540 con 0xd8b210
>>>> 2013-12-07 17:32:42.758993 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 58 ==== osd_op_reply(122
>>>> .bucket.meta.test1:default.95391.1 [create 0~0,call,writefull
>>>> 0~147,setxattr (109)] ack = 0) v4 ==== 259+0+0 (1466420163 0 0)
>>>> 0x7ffbb4000a60 con 0xd8b210
>>>> 2013-12-07 17:32:42.759256 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:123 test1
>>>> [create 0~0,call version.set,writefull 0~111] 4.bddbf0b9 e192) v4 --
>>>> ?+0 0x7ff794008960 con 0xd8b210
>>>> 2013-12-07 17:32:42.760000 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 59 ==== osd_op_reply(123 test1
>>>> [create 0~0,call,writefull 0~111] ondisk = -17 (File exists)) v4 ====
>>>> 188+0+0 (208006733 0 0) 0x7ffbb4000a30 con 0xd8b210
>>>> 2013-12-07 17:32:42.760144 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:124 test1 [call
>>>> version.read,getxattrs,stat] 4.bddbf0b9 e192) v4 -- ?+0 0x7ff794008490
>>>> con 0xd8b210
>>>> 2013-12-07 17:32:42.760924 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 60 ==== osd_op_reply(124 test1
>>>> [call,getxattrs,stat] ondisk = 0) v4 ==== 188+0+139 (2921607002 0
>>>> 1685432528) 0x7ffbb4000a30 con 0xd8b210
>>>> 2013-12-07 17:32:42.761044 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:125 test1
>>>> [getxattrs,stat] 4.bddbf0b9 e192) v4 -- ?+0 0x7ff794008100 con
>>>> 0xd8b210
>>>> 2013-12-07 17:32:42.761759 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 61 ==== osd_op_reply(125 test1
>>>> [getxattrs,stat] ondisk = 0) v4 ==== 146+0+91 (167695905 0 2385301879)
>>>> 0x7ffbb4000a30 con 0xd8b210
>>>> 2013-12-07 17:32:42.761908 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.11:6802/225929 -- osd_op(client.95391.0:126 test1 [call
>>>> version.check_conds,call version.read,read 0~524288] 4.bddbf0b9 e192)
>>>> v4 -- ?+0 0x7ff79400c6e0 con 0xd8b210
>>>> 2013-12-07 17:32:42.762712 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.0 10.174.33.11:6802/225929 62 ==== osd_op_reply(126 test1
>>>> [call,call,read 0~111] ondisk = 0) v4 ==== 188+0+159 (3524501340 0
>>>> 3138215039) 0x7ffbb4000a30 con 0xd8b210
>>>> 2013-12-07 17:32:42.762848 7ff79b1c6700  1 -- 10.174.33.11:0/1270294
>>>> --> 10.174.33.13:6800/296091 -- osd_op(client.95391.0:127
>>>> .bucket.meta.test1:default.78189.1 [call version.check_conds,call
>>>> version.read,getxattrs,stat] 4.50558ec5 e192) v4 -- ?+0 0x7ff79400c6e0
>>>> con 0xd8f710
>>>> 2013-12-07 17:32:42.764173 7ffbd96ec700  1 -- 10.174.33.11:0/1270294
>>>> <== osd.24 10.174.33.13:6800/296091 21 ==== osd_op_reply(127
>>>> .bucket.meta.test1:default.78189.1 [call,call,getxattrs,stat] ondisk =
>>>> -125 (Operation canceled)) v4 ==== 259+0+0 (3728706219 0 0)
>>>> 0x7ffbac002090 con 0xd8f710
>>>> 2013-12-07 17:32:42.764338 7ff79b1c6700  0 get_bucket_info returned -125
>>>> 2013-12-07 17:32:42.764368 7ff79b1c6700  0 WARNING: set_req_state_err
>>>> err_no=125 resorting to 500
>>>> 2013-12-07 17:32:42.764431 7ff79b1c6700  2 req 1:0.027995:s3:PUT
>>>> /test1/:create_bucket:http status=500
>>>> 2013-12-07 17:32:42.764561 7ff79b1c6700  1 ====== req done
>>>> req=0xe60860 http_status=500 ======
>>>> 2013-12-07 17:32:42.794156 7ffbd1ffb700  2
>>>> RGWDataChangesLog::ChangesRenewThread: start
>>>>
>>>> -------------------
>>>>
>>>>
>>>> --
>>>> Regards
>>>> Dominik
>>>>
>>>> 2013/12/7 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
>>>>> Not sure what could be the reason. Can you turn set 'debug ms = 1',
>>>>> and 'debug rgw = 20'?
>>>>>
>>>>> Thanks,
>>>>> Yehuda
>>>>>
>>>>> On Sat, Dec 7, 2013 at 4:33 AM, Dominik Mostowiec
>>>>> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>>> Are you running on latest dumpling
>>>>>> Yes. It was installed, not upgraded from prev version.
>>>>>> This is new crated bucket.
>>>>>> I rebuilded cluster from scratch.
>>>>>>
>>>>>> User add command "radosgw-admin user create ..." shows:
>>>>>> WARNING: cannot read region map
>>>>>>
>>>>>> Create first time bucket 'test1' via 's3 -u craete test1' got error.
>>>>>> But in radosgw logs it seems ok:
>>>>>> -------
>>>>>> 2013-12-07 10:40:04.328277 7f7746ff5700  1 ====== starting new request
>>>>>> req=0x1f5c7b0 =====
>>>>>> 2013-12-07 10:40:04.328339 7f7746ff5700  2 req 2:0.000063::PUT
>>>>>> /test1/::initializing
>>>>>> 2013-12-07 10:40:04.328361 7f7746ff5700 10 meta>> HTTP_X_AMZ_DATE
>>>>>> 2013-12-07 10:40:04.328368 7f7746ff5700 10 x>> x-amz-date:Sat, 07 Dec
>>>>>> 2013 09:40:04 GMT
>>>>>> 2013-12-07 10:40:04.328383 7f7746ff5700 10 s->object=<NULL> s->bucket=test1
>>>>>> 2013-12-07 10:40:04.328390 7f7746ff5700  2 req 2:0.000114:s3:PUT
>>>>>> /test1/::getting op
>>>>>> 2013-12-07 10:40:04.328394 7f7746ff5700  2 req 2:0.000118:s3:PUT
>>>>>> /test1/:create_bucket:authorizing
>>>>>> 2013-12-07 10:40:04.334424 7f7746ff5700 10 get_canon_resource(): dest=
>>>>>> 2013-12-07 10:40:04.334433 7f7746ff5700 10 auth_hdr:
>>>>>> PUT
>>>>>>
>>>>>>
>>>>>>
>>>>>> x-amz-date:Sat, 07 Dec 2013 09:40:04 GMT
>>>>>> /test1/
>>>>>> 2013-12-07 10:40:04.334476 7f7746ff5700  2 req 2:0.006200:s3:PUT
>>>>>> /test1/:create_bucket:reading permissions
>>>>>> 2013-12-07 10:40:04.334481 7f7746ff5700  2 req 2:0.006205:s3:PUT
>>>>>> /test1/:create_bucket:verifying op mask
>>>>>> 2013-12-07 10:40:04.334483 7f7746ff5700  2 req 2:0.006207:s3:PUT
>>>>>> /test1/:create_bucket:verifying op permissions
>>>>>> 2013-12-07 10:40:04.335391 7f7746ff5700  2 req 2:0.007115:s3:PUT
>>>>>> /test1/:create_bucket:verifying op params
>>>>>> 2013-12-07 10:40:04.335402 7f7746ff5700  2 req 2:0.007126:s3:PUT
>>>>>> /test1/:create_bucket:executing
>>>>>> 2013-12-07 10:40:05.420459 7f7746ff5700  2 req 2:1.092182:s3:PUT
>>>>>> /test1/:create_bucket:http status=200
>>>>>> 2013-12-07 10:40:05.420621 7f7746ff5700  1 ====== req done
>>>>>> req=0x1f5c7b0 http_status=200 ======
>>>>>> -------
>>>>>>
>>>>>>
>>>>>> Second try:
>>>>>> -------
>>>>>> 2013-12-07 10:40:06.421876 7f778d95d780 10 allocated request req=0x1f5c710
>>>>>> 2013-12-07 10:40:06.421936 7f77317ca700  1 ====== starting new request
>>>>>> req=0x1f5bc10 =====
>>>>>> 2013-12-07 10:40:06.422038 7f77317ca700  2 req 3:0.000104::PUT
>>>>>> /test1/::initializing
>>>>>> 2013-12-07 10:40:06.422069 7f77317ca700 10 meta>> HTTP_X_AMZ_DATE
>>>>>> 2013-12-07 10:40:06.422080 7f77317ca700 10 x>> x-amz-date:Sat, 07 Dec
>>>>>> 2013 09:40:06 GMT
>>>>>> 2013-12-07 10:40:06.422101 7f77317ca700 10 s->object=<NULL> s->bucket=test1
>>>>>> 2013-12-07 10:40:06.422110 7f77317ca700  2 req 3:0.000176:s3:PUT
>>>>>> /test1/::getting op
>>>>>> 2013-12-07 10:40:06.422117 7f77317ca700  2 req 3:0.000183:s3:PUT
>>>>>> /test1/:create_bucket:authorizing
>>>>>> 2013-12-07 10:40:06.429576 7f77317ca700 10 get_canon_resource(): dest=
>>>>>> 2013-12-07 10:40:06.429592 7f77317ca700 10 auth_hdr:
>>>>>> PUT
>>>>>>
>>>>>>
>>>>>>
>>>>>> x-amz-date:Sat, 07 Dec 2013 09:40:06 GMT
>>>>>> /test1/
>>>>>> 2013-12-07 10:40:06.429679 7f77317ca700  2 req 3:0.007745:s3:PUT
>>>>>> /test1/:create_bucket:reading permissions
>>>>>> 2013-12-07 10:40:06.429690 7f77317ca700  2 req 3:0.007756:s3:PUT
>>>>>> /test1/:create_bucket:verifying op mask
>>>>>> 2013-12-07 10:40:06.429693 7f77317ca700  2 req 3:0.007759:s3:PUT
>>>>>> /test1/:create_bucket:verifying op permissions
>>>>>> 2013-12-07 10:40:06.430945 7f77317ca700  2 req 3:0.009010:s3:PUT
>>>>>> /test1/:create_bucket:verifying op params
>>>>>> 2013-12-07 10:40:06.430964 7f77317ca700  2 req 3:0.009030:s3:PUT
>>>>>> /test1/:create_bucket:executing
>>>>>> 2013-12-07 10:40:06.436301 7f77317ca700  0 WARNING: couldn't find acl
>>>>>> header for object, generating default
>>>>>> 2013-12-07 10:40:06.451160 7f77317ca700  0 get_bucket_info returned -125
>>>>>> 2013-12-07 10:40:06.451188 7f77317ca700  0 WARNING: set_req_state_err
>>>>>> err_no=125 resorting to 500
>>>>>> 2013-12-07 10:40:06.451223 7f77317ca700  2 req 3:0.029289:s3:PUT
>>>>>> /test1/:create_bucket:http status=500
>>>>>> 2013-12-07 10:40:06.451335 7f77317ca700  1 ====== req done
>>>>>> req=0x1f5bc10 http_status=500 ======
>>>>>> -------
>>>>>>
>>>>>> ceph -s
>>>>>>   cluster 92833861-954f-4c66-a72b-5a83090a2b3f
>>>>>>    health HEALTH_OK
>>>>>>
>>>>>> ceph -v
>>>>>> ceph version 0.67.4 (ad85b8bfafea6232d64cb7ba76a8b6e8252fa0c7)
>>>>>>
>>>>>> I have strange behavior after cluster create.
>>>>>> All PGs were on osd.0 and marked as stale degraded.
>>>>>> After add more osd's it didn't ifxed.
>>>>>> "ceph pg force_create_pg" helps.
>>>>>>
>>>>>> After setup cluster I changed crushmap.
>>>>>> Removed osd.0 and added it again to cluster.
>>>>>>
>>>>>> It can be a reason?
>>>>>>
>>>>>> ----
>>>>>> Regards
>>>>>> Dominik
>>>>>>
>>>>>> 2013/12/6 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
>>>>>>> I'm having trouble reproducing this one. Are you running on latest
>>>>>>> dumpling? Does it happen with any newly created bucket, or just with
>>>>>>> buckets that existed before?
>>>>>>>
>>>>>>> Yehuda
>>>>>>>
>>>>>>> On Fri, Dec 6, 2013 at 5:07 AM, Dominik Mostowiec
>>>>>>> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>>>> Hi,
>>>>>>>> In version dumpling upgraded from bobtail working create the same bucket.
>>>>>>>>
>>>>>>>> root@vm-1:/etc/apache2/sites-enabled# s3 -u create testcreate
>>>>>>>> Bucket successfully created.
>>>>>>>> root@vm-1:/etc/apache2/sites-enabled# s3 -u create testcreate
>>>>>>>> Bucket successfully created.
>>>>>>>>
>>>>>>>> I installed new dumpling cluster and:
>>>>>>>> root@s1:/var/log/radosgw# s3 -u create test1
>>>>>>>> Bucket successfully created.
>>>>>>>> root@s1:/var/log/radosgw# s3 -u create test1
>>>>>>>>
>>>>>>>> ERROR: ErrorUnknown
>>>>>>>>
>>>>>>>> In radosgw logs:
>>>>>>>>
>>>>>>>> 2013-12-06 13:59:56.083109 7f162d7c2700  1 ====== starting new request
>>>>>>>> req=0xb7d480 =====
>>>>>>>> 2013-12-06 13:59:56.083227 7f162d7c2700  2 req 5:0.000119::PUT
>>>>>>>> /test1/::initializing
>>>>>>>> 2013-12-06 13:59:56.083261 7f162d7c2700 10 meta>> HTTP_X_AMZ_DATE
>>>>>>>> 2013-12-06 13:59:56.083274 7f162d7c2700 10 x>> x-amz-date:Fri, 06 Dec
>>>>>>>> 2013 12:59:56 GMT
>>>>>>>> 2013-12-06 13:59:56.083298 7f162d7c2700 10 s->object=<NULL> s->bucket=test1
>>>>>>>> 2013-12-06 13:59:56.083307 7f162d7c2700  2 req 5:0.000199:s3:PUT
>>>>>>>> /test1/::getting op
>>>>>>>> 2013-12-06 13:59:56.083315 7f162d7c2700  2 req 5:0.000207:s3:PUT
>>>>>>>> /test1/:create_bucket:authorizing
>>>>>>>> 2013-12-06 13:59:56.091724 7f162d7c2700 10 get_canon_resource(): dest=
>>>>>>>> 2013-12-06 13:59:56.091742 7f162d7c2700 10 auth_hdr:
>>>>>>>> PUT
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> x-amz-date:Fri, 06 Dec 2013 12:59:56 GMT
>>>>>>>> /test1/
>>>>>>>> 2013-12-06 13:59:56.091836 7f162d7c2700  2 req 5:0.008728:s3:PUT
>>>>>>>> /test1/:create_bucket:reading permissions
>>>>>>>> 2013-12-06 13:59:56.091848 7f162d7c2700  2 req 5:0.008740:s3:PUT
>>>>>>>> /test1/:create_bucket:verifying op mask
>>>>>>>> 2013-12-06 13:59:56.091852 7f162d7c2700  2 req 5:0.008744:s3:PUT
>>>>>>>> /test1/:create_bucket:verifying op permissions
>>>>>>>> 2013-12-06 13:59:56.093858 7f162d7c2700  2 req 5:0.010750:s3:PUT
>>>>>>>> /test1/:create_bucket:verifying op params
>>>>>>>> 2013-12-06 13:59:56.093882 7f162d7c2700  2 req 5:0.010773:s3:PUT
>>>>>>>> /test1/:create_bucket:executing
>>>>>>>> 2013-12-06 13:59:56.104819 7f162d7c2700  0 WARNING: couldn't find acl
>>>>>>>> header for object, generating default
>>>>>>>> 2013-12-06 13:59:56.132625 7f162d7c2700  0 get_bucket_info returned -125
>>>>>>>> 2013-12-06 13:59:56.132656 7f162d7c2700  0 WARNING: set_req_state_err
>>>>>>>> err_no=125 resorting to 500
>>>>>>>> 2013-12-06 13:59:56.132693 7f162d7c2700  2 req 5:0.049584:s3:PUT
>>>>>>>> /test1/:create_bucket:http status=500
>>>>>>>> 2013-12-06 13:59:56.132890 7f162d7c2700  1 ====== req done
>>>>>>>> req=0xb7d480 http_status=500 ======
>>>>>>>>
>>>>>>>> --
>>>>>>>> Regards
>>>>>>>> Dominik
>>>>>>>> _______________________________________________
>>>>>>>> ceph-users mailing list
>>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Pozdrawiam
>>>>>> Dominik
>>>>
>>>>
>>>>
>>>> --
>>>> Pozdrawiam
>>>> Dominik
>>
>>
>>
>> --
>> Pozdrawiam
>> Dominik
>
>
>
> --
> Pozdrawiam
> Dominik
