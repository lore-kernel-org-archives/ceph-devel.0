From: Matt Benjamin <mbenjamin@redhat.com>
Subject: c++ build flags, clang++, -Wnomismatched-tags?
Date: Wed, 20 Jan 2016 17:39:59 -0500 (EST)
Message-ID: <1295550971.21353553.1453329599755.JavaMail.zimbra@redhat.com>
References: <1853622377.21349293.1453329346090.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:58783 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbcATWkA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 17:40:00 -0500
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id u0KMdxEr007836
	for <ceph-devel@vger.kernel.org>; Wed, 20 Jan 2016 17:39:59 -0500
In-Reply-To: <1853622377.21349293.1453329346090.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ceph C++ devs,

I notice building with clang lots of warnings like:

      'SequencerPosition' defined as a struct here but previously declared as a
      class [-Wmismatched-tags]
struct SequencerPosition {
^
/home/mbenjamin/dev/rgw/ceph-upstream/src/os/ObjectMap.h:24:1: note: did you
      mean struct here?
class SequencerPosition;
^~~~~
struct
3 warnings generated.

induced by -Wmismatched-tags, which apparently clang++ has by default.  As a ISO C++ developer, I don't think of "struct" as a token that can be mismatched with "class" in friend or forward declaration, but clearly the authors of this warning do.

I think my intuition would be to disable this warning.  What do others think?

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
