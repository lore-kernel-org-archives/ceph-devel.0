From: Tone Zhang <tone.zhang@linaro.org>
Subject: Fresh deploy Ceph (Jewel) failed because the ceph OSD deamon is not activated
Date: Fri, 3 Jun 2016 10:36:52 +0800
Message-ID: <CAOCf4A=8WiBpmYV9NBFyQ639TpHxN74h3O6sT1UqMPiopaY5zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33433 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcFCCgx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 22:36:53 -0400
Received: by mail-vk0-f46.google.com with SMTP id r140so97101013vkf.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 19:36:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

I fresh deployed Ceph within 3 ceph nodes according to the manual
http://docs.ceph.com/docs/master/start/quick-ceph-deploy/.
Ceph version is Jewel (ceph version 10.2.1
(3a66dd4f30852819c1bdaa8ec23c795d4ad77269)).
Ubuntu 16.04 is used in each node.
After run the command "ceph-deploy osd activate", there is warning
reported, following an ERROR, ENAMETOOLONG. After check in each ceph
OSD node, the ceph osd daemon is not start up.

According to the installation manual, the below options are not mandatory:
filestore_max_xattr_value_size_XXX
osd_max_object_name_len

In the source code, the value of filestore_max_xattr_value_size_XXX
should be over the value of osd_max_object_name_len, otherwise the
error, ENAMETOOLONG, will be reported.

logical if the options are not mandatory, I think the OSD daemon
should NOT be blocked.
So it should be one bug. Right?
I can reproduce the problem in Jewel and in the source code building
from the latest master branch (version is
9661bbbbd7d0f03095039184f8ed9fb92855d576).
Now the question is that is it one bug? Is there any history behind?
If it is a bug, I'd like to fix it.
What's you opinion? Any suggestion?
I have created one bug to track the issue http://tracker.ceph.com/issues/16070.
Thanks.

Br,
Tone ZHANG
