From: mowang da <whooya.xxl@gmail.com>
Subject: samba write performance
Date: Thu, 7 Jul 2011 19:06:20 +0800
Message-ID: <CAMwsgzMq94tL-OwvB_=TefAxzsmAdAyxv02N46i3tyK2-8ok9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62539 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab1GGLGV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2011 07:06:21 -0400
Received: by eyx24 with SMTP id 24so270065eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2011 04:06:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am trying to use a Ceph kernel  client to mount Ceph DFS(/) and
set up a samba server to share the mount point(/mnt/) to Windows 7.
when l write a large file to the shared directory ., I found that:
Time           eth0       												
HH:MM:SS   KB/s in  KB/s out						CPU     %user     %nice   %system
%iowait    %steal     %idle
18:38:09   4540.85    199.65				06:38:09 PM     all      4.48
0.00      9.45     17.41      0.00     68.66
18:38:10  108359.6    971.33				06:38:10 PM     all     21.05
0.00     39.23      0.00      0.00     39.71
18:38:11  94209.18    837.11				06:38:11 PM     all     27.00
0.00     54.00      0.00      0.00     19.00
18:38:12  108445.3    972.69				06:38:12 PM     all     26.13
0.00     49.25      0.00      0.00     24.62
18:38:13  111292.8    976.45				06:38:13 PM     all     29.65
0.00     47.74      2.51      0.00     20.10
18:38:14  110391.5    954.38				06:38:14 PM     all     23.86
0.00     55.33      0.00      0.00     20.81
18:38:15  110909.2    972.39				06:38:15 PM     all     28.50
0.00     55.00      0.00      0.00     16.50
18:38:16  105417.3   7160.54				06:38:16 PM     all     28.14
0.00     53.27      0.00      0.00     18.59
18:38:17  93842.25  28704.94				06:38:17 PM     all     17.50
0.00     52.50      9.50      0.00     20.50
18:38:18  54239.49  31787.57				06:38:18 PM     all     22.50
0.00     41.50      0.00      0.00     36.00
18:38:19  34258.94  100884.5				06:38:19 PM     all     18.09
0.00     66.83      2.51      0.00     12.56
18:38:20  31679.40  113713.2				06:38:20 PM     all     10.95
0.00     89.05      0.00      0.00      0.00
18:38:21  49619.47  114486.8				06:38:21 PM     all     11.62
0.00     78.28      0.00      0.00     10.10
18:38:22  40821.56  115698.2				06:38:22 PM     all     12.50
0.00     72.50      0.00      0.00     15.00
18:38:23  47052.48  114899.3				06:38:23 PM     all     11.94
0.00     75.12      0.00      0.00     12.94
18:38:24  37556.76  115517.8				06:38:24 PM     all     14.43
0.00     66.67      0.00      0.00     18.91
18:38:25  59026.53  100313.4				06:38:25 PM     all     11.00
0.00     74.00      0.00      0.00     15.00
18:38:26  65620.30  93774.74				06:38:26 PM     all     14.14
0.00     74.24      1.01      0.00     10.61
18:38:27  102363.6  17002.45				06:38:27 PM     all     22.50
0.00     60.00      0.00      0.00     17.50
18:38:28  110130.1    961.28				06:38:28 PM     all     29.85
0.00     52.24      0.00      0.00     17.91
18:38:29  110177.4    974.45				06:38:29 PM     all     29.65
0.00     51.26      0.50      0.00     18.59
18:38:30  111202.0    970.46				06:38:30 PM     all     29.15
0.00     50.75      0.00      0.00     20.10
					
what happens is that the write performance starts to slow down
horribly when the client write data to ceph, I'm wondering if this is
an issue with pdflush or CPU performance limits.
