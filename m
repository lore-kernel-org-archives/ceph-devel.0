From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 09:48:57 -0600
Message-ID: <4FEC7CE9.9090401@sandia.gov>
References: <3069bbf7-ebcf-467f-978f-c8026befe064@mailpro>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:48395 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab2F1PtY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 11:49:24 -0400
In-Reply-To: <3069bbf7-ebcf-467f-978f-c8026befe064@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sage@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>

On 06/28/2012 09:45 AM, Alexandre DERUMIER wrote:
>>> >>Definitely. Seeing perf/oprofile/whatever results for the osd under that
>>> >>workload would be very interesting! We need to get perf going in our
>>> >>testing environment...
> I'm not an expert, but if you give me command line, I'll do it ;)

Thanks to Mark's help, I'm now using:

perf record -g -a sleep 10
perf report --sort symbol --call-graph fractal,5 | more

-- Jim

