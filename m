From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: getting started with RADOSGW
Date: Sun, 22 Jul 2012 15:02:09 -0700
Message-ID: <CAC-hyiHN2_xU0rHfYX9w64zyczjA1Hd+05WD9kMrgK119TzXGg@mail.gmail.com>
References: <CABZB-shn=RtKNFyXEaK5difh=NTfUVzgiF7DGJ8fJJSGO+5pFQ@mail.gmail.com>
	<CAC-hyiGaY6b=3PgY2jANMLM6ALLbe02j9KfWv7vR9JLW5q2XAA@mail.gmail.com>
	<CABZB-shPO1L1Xs9SM6qF3-4c=xpVx7EWjd9i_x8EqTU6M0C5Dg@mail.gmail.com>
	<CAC-hyiEXayeDOTJ-SpvF5Le9B22-ZP_nfpa1xrkAUoVeuYX6iQ@mail.gmail.com>
	<CABZB-siWNpF58Si-z+=YZ3PMoHqcZcjbL6r6Lyu-nyc2GSrZhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45558 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab2GVWCK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Jul 2012 18:02:10 -0400
Received: by bkwj10 with SMTP id j10so4666137bkw.19
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jul 2012 15:02:09 -0700 (PDT)
In-Reply-To: <CABZB-siWNpF58Si-z+=YZ3PMoHqcZcjbL6r6Lyu-nyc2GSrZhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Proulx <jon@jonproulx.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 22, 2012 at 2:04 PM, Jonathan Proulx <jon@jonproulx.com> wrote:
> On Sun, Jul 22, 2012 at 12:31 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>> On Sun, Jul 22, 2012 at 8:46 AM, Jonathan Proulx <jon@jonproulx.com> wrote:
>
>>> are these the right capabilities for that user
>>> (http://ceph.com/docs/master/radosgw/config suggests they are)?
>>>
>>> client.rados.gateway
>>>         key: <redacted>
>>>         caps: [mon] allow r
>>>         caps: [osd] allow rwx
>>
>> I think the radosgw needs the 'w' cap for the monitor for
>> automatically creating the rados pools. Though it may be that you'd be
>> better off creating the pools yourself with the required amount of pgs
>> than letting it do that by itself, as the default number of pgs that
>> will be created is very low.
>>> ceph.conf points to /etc/ceph/keyring.rados.gateway which has is
>>> readable and has matching key
>>>
>> Try running 'ceph auth list' and see if you see the auth info for that
>> user. If not then you'll need to 'ceph auth add' that keyring.
>
> 'ceph auth list' is where I got the capabilites list, though the
> keyring file above list the same caps
>
> Hmmm, how do I change the capabilities of a key, that doc section is
> blank http://ceph.com/docs/master/ops/manage/key/#capabilities.  I
> tried "ceph-authtool -n client.rados.gateway --cap osd 'allow rwx'
> --cap mon 'allow rw' /etc/ceph/keyring.rados.gateway" which changed
> the keyfile but not the output of "ceph auth list"
>
> And radosgw is still exiting with an auth error...
>
> root@ceph-mon:/tmp/rbd# /etc/init.d/radosgw restart
> No /usr/bin/radosgw found running; none killed.
> Starting client.radosgw.gateway...

You're starting radosgw with user 'client.radosgw.gateway', whereas
the key is for user 'client.rados.gateway'.

Yehuda
