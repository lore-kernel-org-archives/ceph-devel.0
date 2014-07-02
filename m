From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: FW: Intel ISA-L EC plugin
Date: Wed, 2 Jul 2014 17:54:47 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE747D71@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE747D5B@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:16862 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbaGBRyt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jul 2014 13:54:49 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE747D5B@CERNXCHG44.cern.ch>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage & Loic et al ...
getting some support from Paul Luse I have finished the refactoring of the EC ISA-L plug-in.


The essential ISA-L v 2.10 sources are now part of the source tree and it builds a single shared library which is portable on platforms with varying CPU extensions (SSE2, AVX, AVX2). I tested on various Intel & AMD processor types.

The build of the plug-in is coupled to the presence of 'yasm' similiar to the crc32c extension in common/ ... (I couldn't build ISA-L on ARM).

It supports two encoding matrices Vandermonde & Cauchy. The techniques are called similar to the one used by Loic in Jerasure "reed_sol_van" & "cauchy". "cauchy" is the default.

Greg Tucker from Intel pointed me to the proper ( and faster ) way of decoding if parity chunks are missing.


??? How do we proceed? I currently rebase against firefly and use its API definition or should this be for a later release with Loic's refactored interface? Shall I make a pull request or shall I hand it over to Loic and he takes care to do the integration including QA etc ...?

??? I have still an open question on the library optimization for decoding(=repair). If you call decoding for a certain set one needs to do a matrix inversion coupled to the given set. If the payload is like 1M the computation of the decoding matrix does not
 play a role. If the payload is 4k it plays a role. Can I assume that the plugin will be called concurrently for the same object with the same set of chunks or would the plugin be called interleaved for many objects with changing chunk configurations? Is the
 EC object called single-threaded or by a thread pool? Will backfilll use 4k IOs or larger?

I would either commit the simple cache mechanism caching the last computed erasure configuration & corresponding matrix or put an LRU cache for the last computed matrices. I prototyped both, but would stick to the simplest required.

Cheers Andreas.
































