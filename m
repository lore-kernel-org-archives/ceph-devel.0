From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: How to make systemd unit files work in all supported distros?
Date: Mon, 8 Feb 2016 21:10:55 -0700
Message-ID: <CALqRxCyG8XsEXf_btKV4RdbHWPzT3sbqk-CQKN=1_9Y4OkwvGw@mail.gmail.com>
References: <56B86372.4020600@suse.cz>
	<CALqRxCwzm-SB6j6VRzHzt+eefLbCB5cjuurP1mnHGAZ_Exjy2g@mail.gmail.com>
	<56B92149.3060905@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36697 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306AbcBIEK4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 23:10:56 -0500
Received: by mail-wm0-f52.google.com with SMTP id p63so140979111wmp.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 20:10:55 -0800 (PST)
In-Reply-To: <56B92149.3060905@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 8, 2016 at 4:14 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 02/08/2016 11:55 PM, Ken Dreyer wrote:
>>
>> Which executables are different? Fedora's pretty flexible about this;
>> I'm sure we could ship ceph-disk in /usr/bin if it lets us align with
>> SUSE or whatever.
>
>
> Here's another one:
>
> https://github.com/ceph/ceph/blob/master/systemd/ceph-osd%40.service#L13
>
> %{_libexecdir} expands to /usr/lib on SUSE :-(
>
> And "sh -c" would not help us here, either.

I see, yeah. Sounds like a .in template is the way to go, then.

- Ken
