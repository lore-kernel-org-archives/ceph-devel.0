From: "ymorita000@gmail.com" <ymorita000@gmail.com>
Subject: Re: found some issues on ceph v0.61.2
Date: Wed, 22 May 2013 10:34:16 -0700
Message-ID: <CAA4Vorq=xZwhzC_YzWDiN6Sr+rjfUXzcKf54-8bNmF7j19cxpA@mail.gmail.com>
References: <CAA4Vorp+ZVDjwxaYV4em12QPvW-RAOuwJyc4y9FcmGd1rWyMig@mail.gmail.com>
	<519AC562.4010805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:59868 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244Ab3EVReR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 May 2013 13:34:17 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so2356454wgh.3
        for <ceph-devel@vger.kernel.org>; Wed, 22 May 2013 10:34:16 -0700 (PDT)
In-Reply-To: <519AC562.4010805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, May 20, 2013 at 5:52 PM, Dan Mick <dan.mick@inktank.com> wrote:
>
>
> On 05/20/2013 05:00 PM, ymorita000@gmail.com wrote:
>>
>> Hi,
>>
>> I have found some issues on ceph v0.61.2 on Ubuntu 12.10.
>>
>> (1) "ceph-deploy osd create" command fails when using --cluster <name>
>> option.
>>
>> [root@host3 yuji_ceph]# ceph-deploy --cluster yuji osd create host1:sdb
>> Traceback (most recent call last):
>>    File "/usr/sbin/ceph-deploy", line 8, in <module>
>>      load_entry_point('ceph-deploy==0.1', 'console_scripts',
>> 'ceph-deploy')()
>>    File "/root/ceph-deploy/ceph_deploy/cli.py", line 112, in main
>>      return args.func(args)
>>    File "/root/ceph-deploy/ceph_deploy/osd.py", line 428, in osd
>>      prepare(args, cfg, activate_prepared_disk=True)
>>    File "/root/ceph-deploy/ceph_deploy/osd.py", line 273, in prepare
>>      s = '{} returned {}\n{}\n{}'.format(cmd, ret, out, err)
>> ValueError: zero length field name in format
>
>
> This is a symptom of Python < 2.7, but you say Ubuntu 12.10; are all the
> hosts running 12.10?  Have you manually configured the hosts to use Python <
> 2.7?
>
> If the hosts are running < 2.7 on purpose, there's a fix for this in git;
> see http://tracker.ceph.com/issues/5086, but it shouldn't be happening on
> 12.10.
>

Oops, I was using CentOS6.0 as a ceph-deploy admin server. Thank you.


>> (2) "service ceph -a start/stop" command is accepted, but nothing happens.
>>
>> root@host1:~# ceph osd tree
>>
>> # id    weight  type name       up/down reweight
>> -1      0.16    root default
>> -2      0.16            host host1
>> 0       0.03                    osd.0   up      1
>> 1       0.03                    osd.1   up      1
>> 2       0.03                    osd.2   up      1
>> 3       0.06999                 osd.3   up      1
>>
>> root@host1:~# /etc/init.d/ceph -a stop
>> root@host1:~# ceph osd tree
>>
>> # id    weight  type name       up/down reweight
>> -1      0.16    root default
>> -2      0.16            host host1
>> 0       0.03                    osd.0   up      1
>> 1       0.03                    osd.1   up      1
>> 2       0.03                    osd.2   up      1
>> 3       0.06999                 osd.3   up      1
>
>
> If you're running on 12.10 with ceph-deploy, you're using Upstart, so you
> probably want upstart commands (start ceph/stop ceph)

What is the Upstart? Are there any references in the Ceph Documentation?


>> By the way, I could not find [osd], [host] and [mon] entry in the
>> /etc/ceph/ceph.conf anymore when I create ceph cluster using
>> "ceph-deploy". Is this information still stored somewhere?
>
>
> Not directly; it's inferred from the presence of directories in
> /var/lib/ceph.  You can, of course, still add configuration options to
> ceph.conf, it's just that you don't have to specify daemon location/address
> there as you used to.

Okay. Thank you.

Yuji

>> Thank you.
>> Yuji
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
