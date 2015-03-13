From: Sage Weil <sweil@redhat.com>
Subject: RE: packages on download.ceph.com
Date: Fri, 13 Mar 2015 16:20:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503131617390.25410@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF91555668ED@SATLEXDAG01.amd.com> <54FDF605.9000302@redhat.com> <54FE066C.2070902@bisect.de> <alpine.DEB.2.00.1503091358380.25972@cobra.newdream.net> <BC97738F8E7C8742BABED7F06FB9DF9155567917@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39294 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbbCMXU2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Mar 2015 19:20:28 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9155567917@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Tom,

On Wed, 11 Mar 2015, Deneau, Tom wrote:
> On that topic, since Ceph is part of Red Hat,
> can the Ceph developers lobby for getting some version of Ceph
> included in the first RHEL aarch64 release?  My understanding is that currently
> Ceph packages are not planned to be included in the default package lists.

Including packages in RHEL generally means they are fully supported, and 
since we don't have any aarch64 hardware in our labs doing Ceph testing 
yet and the storage team isn't focusing on this right now, that doesn't 
surprise me.  I'll ping some people internally though and find out what 
the ARM folks' plans are... I don't know too much about that project!

sage
