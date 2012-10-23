From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: running without cephx
Date: Tue, 23 Oct 2012 13:24:05 -0700
Message-ID: <CAC-hyiGq1hX_CdhgnMOnT-6D3g3PrPE5XXA+v_dKyqWhdM9AXA@mail.gmail.com>
References: <5086FAC1.3030706@inktank.com>
	<CAC-hyiGDzPGMUjoRJH5A1eX1C_yia0LnT2r9JeJNSCSiE2o_4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53844 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757506Ab2JWUYG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 16:24:06 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1778968bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Oct 2012 13:24:05 -0700 (PDT)
In-Reply-To: <CAC-hyiGDzPGMUjoRJH5A1eX1C_yia0LnT2r9JeJNSCSiE2o_4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Oct 23, 2012 at 1:22 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Tue, Oct 23, 2012 at 1:14 PM, Dan Mick <dan.mick@inktank.com> wrote:
>> So, I've discovered that to make "no cephx" work, you need to explicitly set
>> "none" for the three options (thanks to Yehuda for the tip):
>>
>>         auth cluster required = none
>>         auth service required = none
>>         auth supported = none
>>
>> Since "blank" is not an error, but leads to a disagreement about
>> authentication that's fairly hard to diagnose, should we make it an error to
>> specify a blank entry for those items?
>>
> Maybe fix it so that blank entries would be equivalent to 'none'?
>
> Yehuda

That should do it:

diff --git a/src/auth/AuthMethodList.cc b/src/auth/AuthMethodList.cc
index e23ac40..53c8d66 100644
--- a/src/auth/AuthMethodList.cc
+++ b/src/auth/AuthMethodList.cc
@@ -35,6 +35,8 @@ AuthMethodList::AuthMethodList(CephContext *cct, string str)
       lderr(cct) << "WARNING: unknown auth protocol defined: " <<
*iter << dendl;
     }
   }
+  if (auth_supported.empty())
+    auth_supported.push_back(CEPH_AUTH_NONE);
 }

 bool AuthMethodList::is_supported_auth(int auth_type)
