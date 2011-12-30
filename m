From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/2] Add Ceph integration with OCF-compliant HA resource
 managers
Date: Fri, 30 Dec 2011 09:09:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112300908510.32549@cobra.newdream.net>
References: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60366 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab1L3RJr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Dec 2011 12:09:47 -0500
In-Reply-To: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

Hi Florian,

I don't have any first-hand experience with OCF, but I did a quick over 
these look over the code and it looks reasonable enough.  Merged all three 
patches.

Thanks!
sage

On Thu, 29 Dec 2011, Florian Haas wrote:

> Hi everyone,
> 
> please consider reviewing the following patches. These add
> OCF-compliant cluster resource agent functionality to Ceph, allowing
> MDS, OSD and MON to run as cluster resources under compliant managers
> (such as Pacemaker, http://www.clusterlabs.org).
> 
> This new stuff does not build nor install by default; you must enable
> with the "--with-ocf" flag. That same flag maps to a new RPM build
> conditional ("--with ocf") which rolls the resource agents into a
> separate subpackage, "ceph-resource-agents".
> 
> These patches require the tiny patch to the init script that I posted
> here a few days ago.
> 
> Just in case you're interested, all the above changes (including the
> init script patch) since commit e18b1c9734e88e3b779ba2d70cdd54f8fb94743d:
> 
>   rgw: removing swift user index when removing user (2011-12-28 17:00:19 -0800)
> 
> are also available in my GitHub repo at:
>   git://github.com/fghaas/ceph ocf-ra
> 
> Florian Haas (3):
>       init script: be LSB compliant for exit code on status
>       Add OCF-compliant resource agent for Ceph daemons
>       Spec: conditionally build ceph-resource-agents package
> 
>  ceph.spec.in        |   22 ++++++
>  configure.ac        |    8 ++
>  src/Makefile.am     |    4 +-
>  src/init-ceph.in    |    7 ++-
>  src/ocf/Makefile.am |   23 +++++++
>  src/ocf/ceph.in     |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 238 insertions(+), 3 deletions(-)
>  create mode 100644 src/ocf/Makefile.am
>  create mode 100644 src/ocf/ceph.in
> 
> Hope this is useful. All feedback is much appreciated. Thanks!
> 
> Cheers,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
