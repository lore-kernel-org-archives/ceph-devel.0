From: Gregory Farnum <greg@inktank.com>
Subject: Re: deprecating mkcephfs (the arrival of light-weight deployment tools)
Date: Mon, 19 Nov 2012 14:53:14 -0800
Message-ID: <CAPYLRziNKP9GC=ciwcuvtZcWr7uqF5k42cCSOokaxT-fj+MRow@mail.gmail.com>
References: <CAJiejCTWvtn6yS+_9h07t4KWqRHPqT-Oe23KtXmnvf7ZZbsAAw@mail.gmail.com>
	<CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com>
	<1353363220.47659.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53511 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2KSWxO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:53:14 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7670474iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 14:53:14 -0800 (PST)
In-Reply-To: <1353363220.47659.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Isaac Otsiabah <zmoo76b@yahoo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 19, 2012 at 2:13 PM, Isaac Otsiabah <zmoo76b@yahoo.com> wrote:
>
> I am trying to understand ceph deployment direction because from this link http://ceph.com/docs/master/rados/deployment/
> it
>  is mentioned that mkcephfs is dreprecated. It also has the statement
> below which mentions light-weight deployment scripts to help you
> evaluate Ceph.
>
>
> "We provide light-weight deployment scripts to help you evaluate Ceph. For
> professional deployment, you should consider professional deployment systems
> such as Juju, Puppet, Chef or Crowbar."
>
> I  think there is a need to have native ceph deployment tools that aren't dependent upon any third party deployment tools. So my question is this
>
>     1. when will the light-weight deployment scripts be
> available and which ceph version will they be released into?

Check out ceph-deploy, available at
https://github.com/ceph/ceph-deploy. It works against development
releases now, and I believe also against argonaut v0.48.2.

>     2. Now, going forward, when will mkcephfs not work anymore (what ceph version)?

It will continue to work at least as well as it has throughout
Bobtail. (In fact, we're hoping to get a few more patches in that make
it slightly less painful.) However, as anybody who's tried long-term
use of a Ceph cluster deployed with mkcephfs will tell you, it's just
not much fun. This is why we're developing the new ceph-deploy system,
which supports things like adding new daemons, building the system in
multiple, re-runnable steps, etc.

Our messaging has been somewhat inconsistent because there are all
these problems with mkcephfs, but ceph-deploy hasn't been well-tested
yet either. Look for us to start pushing people more strongly in the
coming months once we've validated it.
-Greg
