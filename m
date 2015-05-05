From: John Spray <john.spray@redhat.com>
Subject: Use of YAML for defining complex tests (or Python...?)
Date: Tue, 05 May 2015 12:35:05 +0100
Message-ID: <5548AAE9.2000302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34137 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbbEELfH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 07:35:07 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 10E2B8F011
	for <ceph-devel@vger.kernel.org>; Tue,  5 May 2015 11:35:06 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Zack Cerza <zcerza@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I noted with interest the rather complex .yaml file in this PR:
https://github.com/ceph/ceph-qa-suite/pull/428/files

...with the accompanying addition of loop constructs in this PR:
https://github.com/ceph/teuthology/pull/481

Teuthology YAML files appear to be at risk of becoming a fully fledged 
scripting language.  Why not write python scripts instead, for the more 
complex tests (e.g. anything that would need the full_sequential or loop 
constructs)?

On the cephfs side, we hit the point where test procedures were complex 
enough to need their own mini-framework inside tasks/cephfs -- a similar 
structure could be useful for people working on other subsystems as well.

Cheers,
John
