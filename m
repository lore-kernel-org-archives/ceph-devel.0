From: Dan Mick <dan.mick@inktank.com>
Subject: Re: possible bug in blacklist
Date: Thu, 26 Sep 2013 18:08:31 -0700
Message-ID: <5244DA8F.5010604@inktank.com>
References: <CA+jddaN3M3xhu5ZVpJynivZ8EVMTwsVJcd4tixNae0+HMoBB+A@mail.gmail.com> <5244C877.7070907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:57025 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab3I0BIe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 21:08:34 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so1888066pdj.16
        for <ceph-devel@vger.kernel.org>; Thu, 26 Sep 2013 18:08:34 -0700 (PDT)
In-Reply-To: <5244C877.7070907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Pull request created with fix.

On 09/26/2013 04:51 PM, Dan Mick wrote:
> Ah, yes, that's in the validator for CephEntityAddr; it's not checking
> for the case that no nonce was supplied.  I've filed
> http://tracker.ceph.com/issues/6425.
>
> On 09/24/2013 04:57 PM, Mandell Degerness wrote:
>> See trace below.  We run this command on system restart in order to
>> clear any blacklist which was created while node was mis-behaving.
>> Now, rather than giving a reasonable error, it causes at Traceback:
>>
>> [root@node-172-20-0-13 ~]# ceph osd blacklist rm 172.20.0.13
>> Traceback (most recent call last):
>>    File "/usr/bin/ceph", line 774, in <module>
>>      sys.exit(main())
>>    File "/usr/bin/ceph", line 717, in main
>>      sigdict, inbuf, verbose)
>>    File "/usr/bin/ceph", line 375, in new_style_command
>>      valid_dict = validate_command(sigdict, cmdargs, verbose)
>>    File "/usr/lib64/python2.7/site-packages/ceph_argparse.py", line
>> 890, in validate_command
>>    File "/usr/lib64/python2.7/site-packages/ceph_argparse.py", line
>> 715, in matchnum
>>    File "/usr/lib64/python2.7/site-packages/ceph_argparse.py", line
>> 690, in validate_one
>>    File "/usr/lib64/python2.7/site-packages/ceph_argparse.py", line
>> 284, in valid
>> ValueError: need more than 1 value to unpack
>> [root@node-172-20-0-13 ~]# ceph --version
>> ceph version 0.67.3 (408cd61584c72c0d97b774b3d8f95c6b1b06341a)
>> [root@node-172-20-0-13 ~]#
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
