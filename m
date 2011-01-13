From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: cluster upgrade question
Date: Thu, 13 Jan 2011 08:51:39 -0800
Message-ID: <AANLkTikQHq=2CH7sQ66fQYjZxWiMgSdhJZ-vaGgcoTnD@mail.gmail.com>
References: <AANLkTinS2=iMMJ+JNxdD-oeRUE5OCuLwvgFNr1R7+Lfn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36450 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab1AMQvk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jan 2011 11:51:40 -0500
Received: by ewy5 with SMTP id 5so979027ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Jan 2011 08:51:39 -0800 (PST)
In-Reply-To: <AANLkTinS2=iMMJ+JNxdD-oeRUE5OCuLwvgFNr1R7+Lfn@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ravi Pinjala <pstatic@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 12, 2011 at 10:15 PM, Ravi Pinjala <pstatic@gmail.com> wrote:
> Quick question about cluster upgrades. Are the Ceph protocols nailed
> down enough that it's safe to upgrade a cluster incrementally and mix
> versions of the software, or do I have to take the cluster offline and
> upgrade everything at once?
Interoperability between versions is something we try to maintain, but
at this point isn't guaranteed. I can't think of any situation we've
had where trying to run mixed versions would break your on-disk data,
though, it just might crash your older daemons.

Perhaps somebody else will have other ideas, but if I were upgrading a
cluster I think I'd leave everything running, then upgrade one type of
daemon at a time. ie, install the new software on the monitor
machines, then restart the monitor daemons so they're using the new
code, then install on the OSDs, then install on the MDSes.
-Greg
