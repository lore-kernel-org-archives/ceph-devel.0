From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: An empty vptr in an raw object
Date: Fri, 23 Dec 2016 11:26:51 -0500
Message-ID: <20161223162651.GA8662@ultraspiritum.eng.arb.redhat.com>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
 <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE045604@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <dd12b176-2294-72cd-c2b7-6fff709d44c6@digiware.nl>
 <alpine.DEB.2.11.1612231418570.10615@piezo.novalocal>
 <alpine.DEB.2.11.1612231616060.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753590AbcLWQ2Q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 23 Dec 2016 11:28:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1612231616060.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 23/12/2016, Sage Weil wrote:
[snip]
> Hmm, I jumped to a much older commit and the valgrind warnigns go away; I 
> think it's related to the buffer mempools.  Bisecting.

I ran into a similar problem in test_denc that seems to be caused by
underestimating the needed length of the appender:

39	void test_denc(T v) {
40	  // estimate
41	  size_t s = 0;
42	  denc(v, s);
43	  ASSERT_NE(s, 0u);
44	
45	  // encode
46	  bufferlist bl;
47	  {
48	    auto a = bl.get_contiguous_appender(sizeof(T) * 3);
49	    denc(v, a);
50	  }

This fails (the way you've described) pretty reliably whenever the
overhead of a structure being described is less than three times the
actual encoded length of the structure.

If I change the sizeof(T) * 3 above to s, it works perfectly.
