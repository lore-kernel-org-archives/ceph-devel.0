From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: rbd create error with 0.26
Date: Fri, 12 Aug 2011 10:56:06 -0700
Message-ID: <4E456936.3020800@dreamhost.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>	<CAFGK4NK9d3egypFZt5qySY-3-RbEiOZBbtOX_MbCdiPB8k34MA@mail.gmail.com>	<5fd6193b826df34670addab14a78b6c7@hq.newdream.net>	<CAFGK4N+wDdK13o_Sy+fxRxwZ+mZT+TEUJt3+GhKW8CQRRSE7UQ@mail.gmail.com> <CAFGK4NKoNewHP2E76EJxWBSOTPgSKf=5SemjockSGTEj+1u4hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54566 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab1HLR4G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2011 13:56:06 -0400
In-Reply-To: <CAFGK4NKoNewHP2E76EJxWBSOTPgSKf=5SemjockSGTEj+1u4hA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

(bringing back to the list)

On 08/12/2011 12:33 AM, Simon Tian wrote:
> I have done all these:
> 1 cosd has permission to write /var/lib/ceph/tmp
> 2 The temp partition (/var/lib/ceph/tmp) has the execution permission
> ( no noexec mount option )
> 3 libcls_rbd.so is found in LD_LIBRARY_PATH or in the path specified
> in ceph.conf (osd class dir = /usr/lib64/rados-classes for distros
> like RHEL6)
>
> I am testing on RHEL5.4.
>
> The error didn't disappear....

Could you add 'debug osd = 20' to your ceph.conf, restart your osds, 
then try again? The osd log should tell us the cause of the error.

> 2011/8/12 Simon Tian<aixt2006@gmail.com>:
>> # rbd create foo --size 1024
>> 2011-08-12 10:13:13.180774 7f4c9a6656f0 librbd: failed to assign a
>> block name for image
>> create error: Input/output error
>>
>>
>> 2011/8/11 Josh Durgin<josh.durgin@dreamhost.com>:
>>> On Thu, 11 Aug 2011 22:49:11 +0800, Simon Tian<aixt2006@gmail.com>
>>> wrote:
>>>> Hi folks,
>>>>
>>>>        This assert failure appeared in ceph-0.31 when creating a pool,
>>>> could anyone help me?
>>>>
>>>> Thx
>>>> Simon
>>>
>>> What's the error?
>>>
>>

