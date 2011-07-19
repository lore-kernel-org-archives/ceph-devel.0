From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: [PATCH] crushtool: Add call to global_init() to avoid dout segfault
Date: Tue, 19 Jul 2011 15:29:14 -0700
Message-ID: <CA+qbEUMV4FG7k2k8i-kRsedRqcqyzrHF6HyBPsfNRQzij2gE0w@mail.gmail.com>
References: <1310509259-29635-1-git-send-email-jaschut@sandia.gov>
	<Pine.LNX.4.64.1107132131240.22389@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51560 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab1GSW3R convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 18:29:17 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id F12BDC093
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 15:29:41 -0700 (PDT)
Received: from mail-fx0-f52.google.com (mail-fx0-f52.google.com [209.85.161.52])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 4289BC0DD
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 15:29:41 -0700 (PDT)
Received: by fxd18 with SMTP id 18so597109fxd.11
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 15:29:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107132131240.22389@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

Just to follow up on this thread, this was resolved by
56abfd89615c77287f091679e6be59045f05081a.

And thanks for the patch, Jim.

cheers,
Colin


On Wed, Jul 13, 2011 at 9:39 PM, Sage Weil <sage@newdream.net> wrote:
> Hey Colin,
>
> I applied this to stable, but now crushtool is trying to read ceph.co=
nf,
> despite CINIT_FLAG_NO_DEFAULT_CONFIG_FILE... I fixed it up in
> wip-default-conf, can you take a look?
>
> thanks!
> sage
>
>
> On Tue, 12 Jul 2011, Jim Schutt wrote:
>
>>
>> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
>> ---
>> =A0src/crushtool.cc | =A0 =A04 ++++
>> =A01 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/crushtool.cc b/src/crushtool.cc
>> index f2a35f9..336d456 100644
>> --- a/src/crushtool.cc
>> +++ b/src/crushtool.cc
>> @@ -845,6 +845,10 @@ int main(int argc, const char **argv)
>> =A0 =A0map<int, int> device_weight;
>> =A0 =A0DEFINE_CONF_VARS(usage);
>>
>> + =A0global_init(args, CEPH_ENTITY_TYPE_CLIENT, CODE_ENVIRONMENT_UTI=
LITY,
>> + =A0 =A0 =A0 =A0 =A0 CINIT_FLAG_NO_DEFAULT_CONFIG_FILE);
>> + =A0common_init_finish(g_ceph_context);
>> +
>> =A0 =A0FOR_EACH_ARG(args) {
>> =A0 =A0 =A0if (CEPH_ARGPARSE_EQ("clobber", '\0')) {
>> =A0 =A0 =A0 =A0clobber =3D true;
>> --
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
