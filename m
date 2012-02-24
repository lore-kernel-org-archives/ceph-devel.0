From: John Alberts <john.m.alberts@gmail.com>
Subject: Re: [Crowbar] barclamp-ceph and crowbar
Date: Fri, 24 Feb 2012 11:35:06 -0600
Message-ID: <CAJBrc2u4AdPHiOEqZjw=bkk98EqUc8B9-FqrOeSJ4TsiAq=+5Q@mail.gmail.com>
References: <CAJBrc2tq856-_CJbC9Ls4MkPWrsXo-+JMy736_ww9CDQGTEoHw@mail.gmail.com>
	<4F47BC1E.1000405@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34531 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab2BXRfI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2012 12:35:08 -0500
Received: by eekc4 with SMTP id c4so1052710eek.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2012 09:35:07 -0800 (PST)
In-Reply-To: <4F47BC1E.1000405@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: crowbar@dell.com, ceph-devel@vger.kernel.org

On Fri, Feb 24, 2012 at 10:34 AM, Martin Mailand <martin@tuxadero.com> wrote:
> Hi John,
> I tried them a few weeks ago, they are developed for crowbar version 1.1 and
> doesn't seem to work with 1.2. If I want to create a proposal, the next page
> is white and an error is log.
> The barclamp installs one ceph-mon node, and several ceph-store nodes. The
> glue to connect your virtual machine to the ceph-store is not included in
> the barclamp.
>
> -martin

Thank you very much for the update.  I'm actually not using Ceph yet.
I'm just looking at what the options are out there for easy shared
storage for the crowbar/openstack.  It looks like Ceph is the only
option so far.

Thanks
John
