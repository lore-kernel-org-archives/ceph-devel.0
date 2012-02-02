From: Mark Kampe <Mark.Kampe@dreamhost.com>
Subject: Re: efficient removal of old objects
Date: Wed, 01 Feb 2012 16:11:30 -0800
Message-ID: <4F29D4B2.6010608@dreamhost.com>
References: <Pine.LNX.4.64.1201311549170.21770@cobra.newdream.net> <CAORUGqCkRzAbXVjGvVDGX=MxURMy5NijsdPGRgWDpgT3_CyMow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44651 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab2BBALb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 19:11:31 -0500
In-Reply-To: <CAORUGqCkRzAbXVjGvVDGX=MxURMy5NijsdPGRgWDpgT3_CyMow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 01/31/12 17:02, Tommi Virtanen wrote:

> To make my point even clearer: point me to another data store that has
> that idiom.

(a) Automatic expiration and deletion is, and has long been, a
     standard feature of archival systems ... and our RADOS
     clouds are much larger than most archival systems.

(b) I have no competent opinions on the short term solution to this
     particular problem, but in the longer term I do not believe
     that garbage collection can or should be entrusted to clients.
     Clients are ephemeral and cannot be depended on to remember,
     a few years (or even hours) from now, that there were some
     files they were supposed to delete.

     IMHO, object store intelligence is not merely about back-ground
     replication and migration, but about "being able to take
     responsibility for the life cycle of the data they hold".
     The amount of data we store will quickly grow beyond the
     ability of external agents to manage it, and lifecycle
     automation will become increasingly critical.
