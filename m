From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: apache/fcgi deprecation?
Date: Mon, 8 Feb 2016 21:09:34 -0700
Message-ID: <CALqRxCz_YLmierMz4HnDs2DET+HuyF_fbxhFTWWSMQ6suEBP2w@mail.gmail.com>
References: <56B42126.7090106@suse.cz>
	<CALqRxCxtJ5a0xB68kSNP7xr3qcJ-rEr=xP+ByqyusyuOWU2HgQ@mail.gmail.com>
	<56B91FA8.8080709@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35942 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbcBIEJf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 23:09:35 -0500
Received: by mail-wm0-f49.google.com with SMTP id p63so140955615wmp.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 20:09:34 -0800 (PST)
In-Reply-To: <56B91FA8.8080709@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 8, 2016 at 4:07 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 02/08/2016 11:57 PM, Ken Dreyer wrote:
>>
>> Sure, please do it!
>>
>> I think it's just a matter of no one having time to remove it.
>
>
> So we could remove the FastCGI dependency from the packaging, too?
>

That would be nice, but currently RGW hard-codes a dependency on
fcgi-devel, and there's no "--without-fcgi" option to ./configure

- Ken
