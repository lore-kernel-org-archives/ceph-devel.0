From: Ryan Grant <rgrant+ceph@metascopic.com>
Subject: Re: roadmap
Date: Thu, 7 Oct 2010 08:17:00 -0700
Message-ID: <AANLkTi=9666u0vppwdGF9S2_Z1bh=dkCTM11O28rqmkK@mail.gmail.com>
References: <Pine.LNX.4.64.1009241526010.17668@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57823 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab0JGPRB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 11:17:01 -0400
Received: by iwn9 with SMTP id 9so949717iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Oct 2010 08:17:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009241526010.17668@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Sep 24, 2010 at 3:48 PM, Sage Weil <sage@newdream.net> wrote:
> I'm also interested in hearing from you what features or issues you a=
re
> most interested in seeing us focus on.

We'd like to see two-tier replication, where writes can succeed on a
local network, yet later reach eventual consistency with a remote
network.

--=20
=A0 Ryan Grant
=A0 Contract System Analyst / on behalf of Willow Garage
=A0 rgrant@metascopic.com
=A0 415.412.3214
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
