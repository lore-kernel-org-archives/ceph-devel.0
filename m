From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Bucket namespaces pull req. 5872
Date: Wed, 14 Oct 2015 23:25:42 -0600
Message-ID: <20151014232542.1f4d6f26@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46567 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbbJOFZo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Oct 2015 01:25:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Radoslaw Zarzynski <rzarzynski@mirantis.com>

I took a decent look at the pull request 5872
  https://github.com/ceph/ceph/pull/5872
It implements something called "bucket namespaces": a way to make
buckets qualified with a prefix that permits different users use
buckets with the same name.

I think I like the idea overall, but the implementation raises
some questions. The most important in my mind is: why use rgw_user?

In the wip-5073, rgw_user is needed because tenant there adds
a namespace both to users and buckets. But here, users are not
in a namespace, only buckets are. Or at least that's what I see
in the code, please set me straight if I'm wrong.

Conceptually, the user name is just a label, and this patch keeps
those labels compatible. I think, the information about a user
should contain the user's bucket namespace, but the user's label
does not need to have it. So, RGWUserInfo should have the bucket
namespace name (and possibly has_own_bns), and rgw_user is superfluous.

If we could get rid of rgw_user, I would be onboard with this.

Less importantly, I do not like the generosity with knobs.
The rgw_swift_create_account_with_bns shold go away with rgw_user.
The rgw_swift_account_in_url should be possible to incorporate
in a compatible fashion (it does not add an extra next_tok()).
The rgw_keystone_accepted_admin_roles... okay, that one might
be needed. Swift has an equivalent of it.

Finally, there are some miniscule technical issues.
 - Is it just me, or do encoding and decoding of RGWUserInfo do
   not match?  Decoding appears to make provision for wip-5073,
   which we may not even need.
 - The --own-bucket-namespace should not be a boolean, but the
   namespace's name.
 - There's some junk imported from wip-5073; I'll work on cleaning
   that up.

-- Pete
