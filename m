From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: experimental features
Date: Mon, 08 Dec 2014 08:33:25 -0600
Message-ID: <5485B6B5.8010802@redhat.com>
References: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net> <CAC6JEv8LVviFoNXB72gKBQ+seNVYphvpwm0QZeOwccPHr7Qatg@mail.gmail.com> <5481EF6B.4010901@redhat.com> <CAOGLoJN2wSxMgtok6aATSW5o-Abqcv2bdVo+dVfaEbG4iyiQSw@mail.gmail.com> <CAPHS-z7cOLokgHe7Ky+SJQMGPbZmY26o+EeA1i=qo+i_XnYg5g@mail.gmail.com>
Reply-To: mnelson@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:41102 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbaLHOd2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Dec 2014 09:33:28 -0500
Received: by mail-qa0-f43.google.com with SMTP id bm13so3383152qab.16
        for <ceph-devel@vger.kernel.org>; Mon, 08 Dec 2014 06:33:28 -0800 (PST)
In-Reply-To: <CAPHS-z7cOLokgHe7Ky+SJQMGPbZmY26o+EeA1i=qo+i_XnYg5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fred Yang <frederic.yang@gmail.com>, Justin Erenkrantz <justin@erenkrantz.com>
Cc: Gregory Farnum <greg@gregs42.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

I've been thinking for a while that we need another more general command 
than Ceph health to more generally inform you about your cluster.  IE I 
personally don't like having min/max PG warnings in Ceph health (they 
can be independently controlled by ceph.conf options but that kind of 
approach won't scale). I'd like another command that I can run that 
tells me about this kind of thing.  Same thing with experimental 
features.  I don't want ceph health warning me if they've been enabled, 
but I do want to know if they've ever been enabled, when, and whether 
they are still in effect.

Mark

On 12/08/2014 06:57 AM, Fred Yang wrote:
> You will have to consider in the real world whoever built the cluster
> might not document the dangerous option to let support stuff or
> successor aware. Thus any experimental feature considered not safe for
> production should be included in a warning message in 'ceph health', and
> logs, either log it periodically or log the warning msg upon restart.
> Feature-wise, 'ceph health detail' should give you a report over all
> important features/options of the cluster as well.
>
> -Fred
>
> On Sun, Dec 7, 2014, 11:15 PM Justin Erenkrantz <justin@erenkrantz.com
> <mailto:justin@erenkrantz.com>> wrote:
>
>     On Fri, Dec 5, 2014 at 12:46 PM, Mark Nelson
>     <mark.nelson@inktank.com <mailto:mark.nelson@inktank.com>> wrote:
>      > I'm in favor of the "allow experimental features" but instead
>     call it:
>      >
>      > "ALLOW UNRECOVERABLE DATA CORRUPTING FEATURES" which makes things
>     a little
>      > more explicit. With great power comes great responsibility.
>
>     +1.
>
>     For Subversion, we utilize SVN_I_LOVE_CORRUPTED_XXX for a few options
>     that can cause data corruption.  -- justin
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/__majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html>
>
