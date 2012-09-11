From: sheng qiu <herbert1984106@gmail.com>
Subject: does ceph consider the device performance for distributing data?
Date: Mon, 10 Sep 2012 22:54:07 -0500
Message-ID: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55707 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab2IKDyI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 23:54:08 -0400
Received: by ieje11 with SMTP id e11so129963iej.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 20:54:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

HI,

i have a simple question.
for distribution workload among OSDs, does ceph do any online modeling
for OSDs, i.e. collect the online IO latency and try to distribute
more workloads to lower latency OSDs? or only based on
capacity/utilization balance?

Thanks,
Sheng

-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
