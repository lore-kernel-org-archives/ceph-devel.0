From: "Don Talton (dotalton)" <dotalton@cisco.com>
Subject: RE: OpenStack and ceph integration with puppet
Date: Tue, 8 Oct 2013 15:20:08 +0000
Message-ID: <57ED724085B72141BB091CF1314E471F01769708@xmb-rcd-x15.cisco.com>
References: <525413DE.9090405@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:43653 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414Ab3JHPUL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Oct 2013 11:20:11 -0400
In-Reply-To: <525413DE.9090405@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Dan Bode <bodepd@gmail.com>

Hi Loic, 

As Sebastien mentioned already there is code that addresses this in my github repo. This was borne out of some needs we have at Cisco, the primary being complete automation of a rbd-backed cloud. We are still using eNovance's puppet-ceph (https://github.com/enovance/puppet-ceph) in our Grizzly orchestration, but will be moving to the cephdeploy module for Havana.

We utilize stackforge's puppet modules to do our heavy lifting, including p-openstack, p-cinder, p-glance. There are dependency chains so that services will be restarted after configuration changes are made. Since many of our customers don't allow their baremetal  nodes Internet access, we've added the packages to our APT repo to avoid the version issues with using either stock or public packages.

You can probably find some other useful code the https://github.com/CiscoSystems/ repo, including what is needed to cohabitate MON/OSD nodes with OpenStack service nodes (https://github.com/CiscoSystems/puppet-coe/tree/grizzly/manifests/ceph) and more. The primary orchestration is in grizzly-manifests. You can see HOWTOs for different deployment scenarios here: http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation. 

Hope this helps some!

Don
