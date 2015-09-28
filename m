From: David Moreau Simard <dms@redhat.com>
Subject: [puppet] Moving puppet-ceph to the Openstack big tent
Date: Mon, 28 Sep 2015 11:31:30 -0400
Message-ID: <CAH7C+Pr2rA65O8gm3B1A64fFPctb_-q=jE=a6AHKJcfHNY1OEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35243 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933698AbbI1Pba (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 11:31:30 -0400
Received: by obbzf10 with SMTP id zf10so129963916obb.2
        for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 08:31:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: openstack-dev@lists.openstack.org

Hi,

puppet-ceph currently lives in stackforge [1] which is being retired
[2]. puppet-ceph is also mirrored on the Ceph Github organization [3].
This version of the puppet-ceph module was created from scratch and
not as a fork of the (then) upstream puppet-ceph by Enovance [4].
Today, the version by Enovance is no longer officially maintained
since Red Hat has adopted the new release.

Being an Openstack project under Stackforge or Openstack brings a lot
of benefits but it's not black and white, there are cons too.

It provides us with the tools, the processes and the frameworks to
review and test each contribution to ensure we ship a module that is
stable and is held to the highest standards.
But it also means that:
- We forego some level of ownership back to the Openstack foundation,
it's technical committee and the Puppet Openstack PTL.
- puppet-ceph contributors will also be required to sign the
Contributors License Agreement and jump through the Gerrit hoops [5]
which can make contributing to the project harder.

We have put tremendous efforts into creating a quality module and as
such it was the first puppet module in the stackforge organization to
implement not only unit tests but also integration tests with third
party CI.
Integration testing for other puppet modules are just now starting to
take shape by using the Openstack CI inrastructure.

In the context of Openstack, RDO already ships with a mean to install
Ceph with this very module and Fuel will be adopting it soon as well.
This means the module will benefit from real world experience and
improvements by the Openstack community and packagers.
This will help further reinforce that not only Ceph is the best
unified storage solution for Openstack but that we have means to
deploy it in the real world easily.

We all know that Ceph is also deployed outside of this context and
this is why the core reviewers make sure that contributions remain
generic and usable outside of this use case.

Today, the core members of the project discussed whether or not we
should move puppet-ceph to the Openstack big tent and we had a
consensus approving the move.
We would also like to hear the thoughts of the community on this topic.

Please let us know what you think.

Thanks,

[1]: https://github.com/stackforge/puppet-ceph
[2]: https://review.openstack.org/#/c/192016/
[3]: https://github.com/ceph/puppet-ceph
[4]: https://github.com/redhat-cip/puppet-ceph
[5]: https://wiki.openstack.org/wiki/How_To_Contribute

David Moreau Simard
