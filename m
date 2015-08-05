From: Sage Weil <sage@newdream.net>
Subject: Re: Should pgls filters be part of object classes?
Date: Wed, 5 Aug 2015 06:04:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508050604330.22099@cobra.newdream.net>
References: <CALe9h7ds-M+orF+ao70GqN+uFkwiONnbHjzWOXPpFS3crs+YBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58364 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbHENE4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 09:04:56 -0400
In-Reply-To: <CALe9h7ds-M+orF+ao70GqN+uFkwiONnbHjzWOXPpFS3crs+YBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Samuel Just <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 5 Aug 2015, John Spray wrote:
> So, I've got this very-cephfs-specific piece of pgls filtering code in
> ReplicatedPG:
> https://github.com/ceph/ceph/commit/907a3c5a2ba8e3edda18d7edf89ccae7b9d91dc5
> 
> I'm not sure I'm sufficiently motivated to create some whole new
> plugin framework for these, but what about piggy-backing on object
> classes?  I guess it would be an additional
> cls_register_filter("myfilter", my_callback_constructor) fn.
> 
> tl;dr; How do people feel about extending object classes to include
> providing PGLS filters as well?

This seems like the way to do it...

sage
