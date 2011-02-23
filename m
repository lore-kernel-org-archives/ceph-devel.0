From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: g_conf.id, g_conf.name, g_conf.type and friends
Date: Wed, 23 Feb 2011 14:26:33 -0800
Message-ID: <AANLkTinGw2Mf611-O72RSw-fk7JPTuahvP83BECKkX=A@mail.gmail.com>
References: <AANLkTi=zwxN0RW-gjejEONnvpR+RyVUTdx4mWB1qh=En@mail.gmail.com>
	<20110223221353.GA30697@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36883 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab1BWWdn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 17:33:43 -0500
Received: by fxm17 with SMTP id 17so4594448fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 14:33:42 -0800 (PST)
In-Reply-To: <20110223221353.GA30697@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 23, 2011 at 2:13 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Wed, Feb 23, 2011 at 01:58:19PM -0800, Colin Patrick McCabe wrote:
>> *** g_conf.id: this is a username or a daemon name, depending on the program.
>> It defaults to "admin" for our various command-line tools, but can be
>> changed by the -i command-line argument.
>> For an MDS, this would be "a" or "b", or similar.
>
> Noob question: why not 0, 1, ..?

You're not the only one to ask why OSDs are osd.0, osd.1, etc.,
whereas MDSes are mds.a, mds.b, etc. I think the reasons are
historical.

>
>> *** g_conf.type: nobody seems to know what this is.
>> It seems like at one point, g_conf.type was intended to be one of
>> "auth", "mon", "osd", "mds", or "client".
>
> This seems to be tied to cconf's use of "type" as in sections "osd0"
> and "osd.0" are both type=osd, id=0. So, it soudns to be like it's
> there mostly to get around the fact that config section names are not
> predictable.

When filling out a configuration section for the first OSD, you can
use either "osd.0" or "osd0" as the section name.

This is kind of an obscure configuration quirk, though. My point was
that g_conf.type is redundant since we have the same info in a nicely
parsed form in g_conf.entity_name. (There's no reason we can't
continue to support the quirky no-period syntax either.)

Colin
