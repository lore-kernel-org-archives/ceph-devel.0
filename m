From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 05 Dec 2014 06:11:24 -0800
Message-ID: <5481bd0c47851_8b7113532072648@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:64508 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbaLEOLZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Dec 2014 09:11:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

2 new defect(s) introduced to ceph found with Coverity Scan.
14 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1256941:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf_w32.c: 2309 in gf_w32_split_init()

** CID 1256942:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf_w8.c: 1147 in gf_w8_table_init()


________________________________________________________________________________________________________
*** CID 1256941:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf_w32.c: 2309 in gf_w32_split_init()
2303       if ((h->arg1 == 4 && h->arg2 == 32) || (h->arg1 == 32 && h->arg2 == 4) ||
2304           ((issse3 || isneon) && h->mult_type == GF_REGION_DEFAULT)) {
2305         ld4 = (struct gf_split_4_32_lazy_data *) h->private;
2306         ld4->last_value = 0;
2307         if ((h->region_type & GF_REGION_NOSIMD) || !(issse3 || isneon)) {
2308           gf->multiply_region.w32 = gf_w32_split_4_32_lazy_multiply_region;
>>>     CID 1256941:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "if (isneon) {
} else if (h-...".
2309         } else if (isneon) {
2310     #ifdef ARM_NEON
2311           gf_w32_neon_split_init(gf);
2312     #endif
2313         } else if (h->region_type & GF_REGION_ALTMAP) {
2314           gf->multiply_region.w32 = gf_w32_split_4_32_lazy_sse_altmap_multiply_region;

________________________________________________________________________________________________________
*** CID 1256942:  Logically dead code  (DEADCODE)
/erasure-code/jerasure/gf-complete/src/gf_w8.c: 1147 in gf_w8_table_init()
1141       use_simd = 1;
1142     #else
1143       use_simd = 0;
1144     #endif
1145     
1146       if (h->mult_type == GF_MULT_DEFAULT && use_simd) {
>>>     CID 1256942:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "dd = (struct gf_w8_default_...".
1147         dd = (struct gf_w8_default_data *)h->private;
1148         scase = 3;
1149         bzero(dd->high, sizeof(uint8_t) * GF_FIELD_SIZE * GF_HALF_SIZE);
1150         bzero(dd->low, sizeof(uint8_t) * GF_FIELD_SIZE * GF_HALF_SIZE);
1151         bzero(dd->divtable, sizeof(uint8_t) * GF_FIELD_SIZE * GF_FIELD_SIZE);
1152         bzero(dd->multtable, sizeof(uint8_t) * GF_FIELD_SIZE * GF_FIELD_SIZE);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

