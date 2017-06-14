From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 09:50:08 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323584-970273653-1497459010=:5364"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56725 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751958AbdFNQuM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 12:50:12 -0400
In-Reply-To: <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-970273653-1497459010=:5364
Content-Type: text/plain; charset=US-ASCII; format=flowed


Here's a C++11 version that might be useful to you (largely untested,
and I'm only on my first cup of coffee, so... ;>).

-Jesse
--8323584-970273653-1497459010=:5364
Content-Type: text/x-c; name=constexpr-strlen.cpp
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LSU.2.21.1706140950070.5364@ancalagon.suse.de>
Content-Description: constexpr strlen() for C++11
Content-Disposition: attachment; filename=constexpr-strlen.cpp

77u/Ly8gQysrMTEgY29uc3RleHByIHN0cmluZyBsZW5ndGg6DQoNCiNpbmNs
dWRlIDxpb3N0cmVhbT4NCiNpbmNsdWRlIDxjc3RyaW5nPg0KDQpzaXplX3Qg
Y29uc3RleHByIHN0cmluZ19sZW5ndGgoY29uc3QgY2hhciAqcykNCnsNCiBy
ZXR1cm4gMCA9PSAqcyA/IDAgOiAxICsgc3RyaW5nX2xlbmd0aCgxICsgcyk7
DQp9DQoNCmludCBtYWluKCkNCnsNCg0KIHsNCiBjb25zdGV4cHIgY29uc3Qg
Y2hhciAqcyA9ICJIb3dkeSEiOw0KIGNvbnN0ZXhwciBhdXRvIGxlbiA9IHN0
cmluZ19sZW5ndGgocyk7DQogYXV0byBydW50aW1lX2xlbiA9IHN0cmxlbihz
KTsNCiBzdGQ6OmNvdXQgPDwgbGVuIDw8ICIsICIgPDwgcnVudGltZV9sZW4g
PDwgJ1xuJzsNCiB9DQoNCiB7DQogY29uc3RleHByIGNvbnN0IGNoYXIgKnMg
PSAiIjsNCiBjb25zdGV4cHIgYXV0byBsZW4gPSBzdHJpbmdfbGVuZ3RoKHMp
Ow0KIGF1dG8gcnVudGltZV9sZW4gPSBzdHJsZW4ocyk7DQogc3RkOjpjb3V0
IDw8IGxlbiA8PCAiLCAiIDw8IHJ1bnRpbWVfbGVuIDw8ICdcbic7DQogfQ0K
IA0KIC8vIC4uLm5vdGUgdGhhdCB0cnlpbmcgdG8gcGFzcyBpbiBhIG51bGxw
dHIgaXMgbm90IGFsbG93ZWQgaW4NCiAvLyBhIGNvbnN0ZXhwci4gDQp9DQo=

--8323584-970273653-1497459010=:5364--
