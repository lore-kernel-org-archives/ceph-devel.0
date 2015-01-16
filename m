From: Sage Weil <sweil@redhat.com>
Subject: straw2 and ln calculation
Date: Thu, 15 Jan 2015 18:21:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501151728200.2501@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948AbbAPCWC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Jan 2015 21:22:02 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiaoxi.chen@intel.com, stephen.l.blinick@intel.com
Cc: ceph-devel@vger.kernel.org

Hi everyone,

I took at look at the optimized straw2 code today.  There was one typo 
(s/i/u/) and it looks like it works as well as the previous version.  I've 
pushed the latest code and some additional tests to the wip-crush-straw2 
branch.

I went on to do some tests of the variance in the resulting distribution 
when the weights are all identical vs somewhat variable vs very skewed. I 
found that for a more 'typical' distribution of weights (e.g, .5 - 3) the 
std deviation stays flat.  However, for very large skews, there are 
interesting effects that emerge based on very small differences in the ln 
value.  For example, here we adjust the table value into a negative 
integer in mapper.c:

		ln = crush_ln(u) - 0x10000;

If I adjust that 0x10000 value only slightly, and generate a distribution 
across a set of scaled weights (e.g., 1, 2, 4, 8, 16, 32), I will see the 
low weights either more heavily or less heavily weighted than they should 
be.  0x10000 skews them a bit low, 0xffff skews them a bit high.  e.g., 
for 0x10000 I get

expect			169.664
osd	weight	count	adjusted
0	1	102	102    <-- here
1	1.75	212	121
2	3.062	442	144
3	5.359	858	160
4	9.379	1483	158
5	16.41	2673	162
6	28.72	4756	165
7	50.27	8620	171
8	87.96	14851	168
9	153.9	26019	169
10	269.4	45674	169
11	471.4	79768	169
12	825	139949	169
13	1444	245958	170
14	2527	428635	169
std dev 88.6993
     vs 12.1484	(expected)

While for 0xffff I get:

expect			169.664
osd	weight	count	adjusted
0	1	272	272
1	1.75	395	225
2	3.062	596	194
3	5.359	1009	188
4	9.379	1665	177
5	16.41	2869	174
6	28.72	4936	171
7	50.27	8769	174
8	87.96	14981	170
9	153.9	26102	169
10	269.4	45729	169
11	471.4	79737	169
12	825	139719	169
13	1444	245486	170
14	2527	427735	169
std dev 121.243
     vs 13.1205	(expected)

This could be written off to chance, but I see the same effect amplified 
for 0xfffe and 0x10001.

I suppose if we have to choose I think skewing high makes more sense since 
it means the high weight items won't skew high and overfill (although in 
practice that doesn't seem to be happening.. it's only on the low end that 
things get wonky.. the high end looks quite good).

In any case, two things:

1) Maybe someone can check my math on the stddev calculation.  I'm scaling 
the actual placement count by the weight (adj = count/weight) and then 
doing the stddev of the adjusted values.  But the expected value is always 
about 1/3 or 1/4 of that.  I can't tell if that's because the hash is weak 
or because I'm doing something wrong with the calculation.  Notably, if I 
plug in rand() with equal weights for a sanity check, I still get a stddev 
of 953 vs expected 249... about what I see from straw2.  Strangely when 
I use straw I get a bit better than taht, 476.  Am I crazy?  See:

 ./unittest_crush_wrapper --gtest_filter=CrushWrapper.straw2

2) Given how sensitive the ln value is to 0xffff vs 0x10000, I'm highly 
suspicious that slightly better precision will help us out.  Notably, we 
do

		ln = crush_ln(u) - 0x10000;

		/*
		 * divide by 16.16 fixed-point weight
		 */
		draw = (ln << 32) / bucket->item_weights[i];

...so some extra bits of precision (instead of having the lower 32 zeroed) 
would probably help a lot.

Can crush_ln() be modifed to provide more bits of precision without 
increasing the size of the tables?  I don't really understand the math 
it's based on, but it looks like the same curve is being added in with 
different precision or something.. and a lot of bits in LH are being 
thrown out here

    LH >>= (48-12);

If there were 8 more bits returned from crush_ln and we shifted by 8 fewer 
bits in bucket_straw2_choose, for example, I bet we could eliminate some 
of the low-weight effect I'm seeing.

To see what I'm seeing, you can run

 ./unittest_crush_wrapper --gtest_filter=CrushWrapper.straw2_stddev

Any input would be helpful, thanks!
sage

