From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Transitioning Ceph from Autotools to CMake
Date: Wed, 05 Aug 2015 13:14:26 +0200
Message-ID: <1438773266.20202.37.camel@redhat.com>
References: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
	 <1438457056.20202.29.camel@redhat.com>
	 <CALe9h7eUFQ9Ujcc6y_gPatkE=x1psdKMdSaGroav+i8XRzVSnw@mail.gmail.com>
	 <CALe9h7fuhp5ZSinJ9URnTn+x1nF+89BHYYRZhfPv5bRxG7wQKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43200 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbbHELO3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 Aug 2015 07:14:29 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 6A3D436AA30
	for <ceph-devel@vger.kernel.org>; Wed,  5 Aug 2015 11:14:29 +0000 (UTC)
In-Reply-To: <CALe9h7fuhp5ZSinJ9URnTn+x1nF+89BHYYRZhfPv5bRxG7wQKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ali Maredia <amaredia@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 2015-08-04 at 00:38 +0100, John Spray wrote:
> OK, here are vstart+ceph.in changes that work well enough in my out of
> tree build:
> https://github.com/ceph/ceph/pull/5457

Great!
> 
> John
> 
> On Mon, Aug 3, 2015 at 11:09 AM, John Spray <jspray@redhat.com> wrote:
> > On Sat, Aug 1, 2015 at 8:24 PM, Orit Wasserman <owasserm@redhat.com> wrote:
> >>
> >>
> >> 3. no vstart.sh , starting working on this too but have less progress
> >> here. At the moment in order to use vstart I copy the exe and libs to
> >> src dir.
> >
> > I just started playing with CMake on Friday, adding some missing cephfs
> > bits.  I was going to fix (3) as well, but I don't want to duplicate work
> > -- do you have an existing branch at all?  Presumably this will mostly be a
> > case of adding appropriate prefixes to commands.
> >
> > Cheers,
> > John


