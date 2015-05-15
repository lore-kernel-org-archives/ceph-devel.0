From: Artem Elkin <Artem.Elkin@icl-services.com>
Subject: straw2-like algorithm
Date: Fri, 15 May 2015 21:33:16 +0000
Message-ID: <DB3PR03MB06841B94BC544DA1466E1E95D4C70@DB3PR03MB0684.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db3on0127.outbound.protection.outlook.com ([157.55.234.127]:3655
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934608AbbEOVdT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 17:33:19 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I've checked straw2 algorithm. It uses two 2Kb lookup tables to determine the log values. The exponential distribution could be achieved as a sum of squares of normally distributed numbers. And sum of multiple uniformly distributed values is a good approximation to the normal distribution. Event with 4 bytes sum the result is quite ok.
I've tried this (the code is in C#, but I believe you'll catch the idea):

public Item Select(Obj obj, out int iters)
{
    iters = 0;
    while (true)
    {
        ++iters;
        Item selectedItem = null;
        long min = long.MaxValue;
        for (int index = 0; index < Items.Count; index++)
        {
            var item = Items[index];
            if (item.Weight == 0)
                continue;
            var k = index + 1;
            byte[] rnd1 = obj.GetPseudoRandom(iters * k);
            byte[] rnd2 = obj.GetPseudoRandom(2 * iters + rnd1[0] * k);

            int sum1 = 2;//avarage sbyte is -0.5; move the center to 0
            for (int i = 0; i < 4; i++)
                sum1 += (sbyte)rnd1[i];

            int sum2 = 2;
            for (int i = 0; i < 4; i++)
                sum2 += (sbyte)rnd2[i];

            long rnd = sum1 * sum1 + sum2 * sum2; //approx exponential
            rnd <<= 30;
            rnd /= item.Weight;
            if (rnd < min)
            {
                min = rnd;
                selectedItem = item;
            }
        }

        if (!selectedItem.disabled)
            return selectedItem;
    }
}
( https://github.com/artelk/CRUSH_Selection_Algorithm_Test/blob/master/Program.cs )

With 10 items (with weights 1..2) within the bucket and 10^5 objects the object distribution is like this:

Weight:1, w:0.0625, diff:-1.38%, count:6164
Weight:2, w:0.1250, diff:-1.65%, count:12294
Weight:1, w:0.0625, diff:1.57%, count:6348
Weight:1, w:0.0625, diff:-0.18%, count:6239
Weight:2, w:0.1250, diff:0.19%, count:12524
Weight:2, w:0.1250, diff:1.43%, count:12679
Weight:2, w:0.1250, diff:0.92%, count:12615
Weight:2, w:0.1250, diff:0.77%, count:12596
Weight:1, w:0.0625, diff:0.59%, count:6287
Weight:2, w:0.1250, diff:-1.97%, count:12254

So the deviation from the expected numbers is quite small. With 10^6 objects the deviation becomes lesser than 1%. I've tried to add more bucket items with different weights and tried to change the weights of arbitrary items. The amount of moved objects is very close to optimal one.
What do you think of that?

Btw, I've tried another algorithm. That is of O(1) complexity. But it requires a few seconds for initialization (this can be optimized) and creates a several megabyte array which is cached until the next changes in crush map and\or osd weights. Could you tell me if the selection algorithms (straw\tree\list\...) are called every time the object is read\written or there is some memory cached {pg_id->[osd list]} table that is used for the placement decision?

Regards,
Artem
