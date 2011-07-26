From: Christian Brunner <chb@muc.de>
Subject: Re: peering PGs
Date: Tue, 26 Jul 2011 20:46:02 +0200
Message-ID: <CAO47_-8veR6AzSngmKxNi0uadp9K9_fyw2aGr8nGFcDLhY4ZQA@mail.gmail.com>
References: <CAO47_-87BvxVrgAXEqX6y59Mv_fmNZ9b=BK056OUiCSrt9Dwng@mail.gmail.com>
	<CAO47_-_UMAs5sgcV+iMa8dnV4JkrHSi9x+q54vPRac2Xwo1taQ@mail.gmail.com>
	<Pine.LNX.4.64.1107260756160.5718@cobra.newdream.net>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59098 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab1GZSqE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 14:46:04 -0400
Received: by vxh35 with SMTP id 35so539243vxh.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2011 11:46:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107260756160.5718@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

2011/7/26 Sage Weil <sage@newdream.net>:
> On Tue, 26 Jul 2011, Christian Brunner wrote:
>> OK =A0I've solved this by myself.
>>
>> Since I knew that ther is replication between
>>
>> osd001 and osd005,
>>
>> as well as
>>
>> osd001 and osd015,
>> osd001 and osd012,
>>
>> I decided to take osd005, osd012 and osd015 offline. After that ceph
>> started to rebuild the PGs on other nodes.
>
> At the same time you mean? =A0Or just restarted them?

At the same time.

> The usual way to debug these situations is:
>
> =A0- identify a stuck pg
> =A0- figure out what osds it maps to. =A0[15,1]
> =A0- turn on logs on those nodes:
> =A0 =A0ceph osd tell 15 injectargs '--debug-osd 20 --debug-ms 1'
> =A0 =A0ceph osd tell 1 injectargs '--debug-osd 20 --debug-ms 1'
> =A0- restart peering by togging the primary (first osd, 15)
> =A0 =A0ceph osd down 15
> =A0- send us the resulting logs (for all nodes)
>
> Even better if you also include other (old) osds that include pg data
> (osd1 in your case) in this.
>
> We definitely want to fix the core issue, so any help gathering the l=
ogs
> would be appreciated! =A0It's also possible that the above will 'fix'=
 it
> because the peering issue is hard to hit. =A0In that case, cranking u=
p the
> debug level after the initial crash but before you restart everything
> might be a good idea.

I will turn on debuging next time.

I think it is possible to hit the issue, when an osd that is the
destination of a rebuild, fails at the time a rebuild is performed.
But I have not verified this.

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
