From: Owen Synge <osynge@suse.com>
Subject: python-ceph-cfg a ceph deployment library
Date: Mon, 30 May 2016 17:31:33 +0200
Message-ID: <574C5CD5.7060801@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:58765 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbcE3Pbk (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 30 May 2016 11:31:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Dear all,

I have created a stand alone local library for deploying ceph.

	https://github.com/oms4suse/python-ceph-cfg

Already it provides much of the functionality of ceph-deploy.

=46ront ends:

This library already has a salt front end as an execution module:

	https://github.com/oms4suse/sesceph

I intend to provide a CLI front end for this library if people are
interested, this would provide an alternative to ceph-deploy for zero
infrastructure installs.

Currently it handles keyrings, mon osd, rgw and mds entities, and runs
on SUSE SLE12, and OpenSUSE LEAP as well as Centos/Scientific Linux 7.

Potential CLI front end:

If I develop the CLI front end I am considering that it would differ
from ceph deploy in 4 main ways:

(0) Target reuse as a non interactive installer.

(1) It would configure ceph based on a configuration rather than comman=
d
line arguments.

(2) Configure the cluster in one operation.

(3) be run on each node, rather than doing remote operations, outside
the remote operations that are provided by ceph CLI tools.

But lets not get ahead of ourselves talking about a CLI front end to
python-ceph-cfg.

Current status of my work:

This library is a spin off from my work on salt. I am working on a long
term project to make a ceph deployment and management framework for
salt, where we hope to manage day to day operations as well as just
deployment. Currently we have only have salt based deployment of ceph
using this library, but this simple file will allow a complete cluster
to be deployed:

	https://github.com/oms4suse/sesceph/blob/master/examples/cluster_build=
up.sls

My bosses are keen for me to upstream my work to the ceph project rathe=
r
than the salt project, and so for a first stage I am hoping to put this
library into the ceph project.

What are the stages to achieve moving this repo into the ceph project?

Best regards

Owen

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
