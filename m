From: ZhuRongze <zrz4ceph@gmail.com>
Subject: I found some problem in CRUSH code
Date: Wed, 15 Feb 2012 21:51:10 +0800
Message-ID: <4F3BB84E.50209@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000207080806050909040900"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41346 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab2BONvS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2012 08:51:18 -0500
Received: by iacb35 with SMTP id b35so1470277iac.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2012 05:51:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000207080806050909040900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The function crush_adjust_tree_bucket_item_weight in 
ceph-0.41/src/crush/builder.c seem to  have a bug. The argument weight 
is no use, because it is assigned .
--------------------------------------------------------------------
int crush_adjust_tree_bucket_item_weight(struct crush_bucket_tree 
*bucket, int item, int weight)
{
     int diff;
     int node;
     unsigned i, j;
     unsigned depth = calc_depth(bucket->h.size);

     for (i = 0; i < bucket->h.size; i++) {
         if (bucket->h.items[i] == item)
             break;
     }
     if (i == bucket->h.size)
         return 0;

     node = crush_calc_tree_node(i);
     diff = weight = bucket->node_weights[node];
     bucket->node_weights[node] = weight;
     bucket->h.weight += diff;

     for (j=1; j<depth; j++) {
         node = parent(node);
         bucket->node_weights[node] += diff;
     }

     return diff;

--------------------------------------------------------------------
The function crush_adjust_list_bucket_item_weight also have a same problem.

-ZhuRongze

--------------000207080806050909040900
Content-Type: text/x-vcard; charset=utf-8;
 name="zrz4ceph.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="zrz4ceph.vcf"

YmVnaW46dmNhcmQNCmZuOlJvbmd6ZSBaaHUNCm46Wmh1O1Jvbmd6ZQ0Kb3JnOlNJTkE7U1dT
DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------000207080806050909040900--
