From: Methuku Karthik <kmeth@seas.upenn.edu>
Subject: [GSOC] Introduction Mail : ceph-mgr: Smarter Reweight-by-Utilization
Date: Mon, 27 Mar 2017 16:49:34 -0400
Message-ID: <CAOnoakd7u3OfOi1-wotvtKC=Kc5zaQbNMBQtShpDHhPRa94eCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33324 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdC0Utv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Mar 2017 16:49:51 -0400
Received: by mail-qk0-f175.google.com with SMTP id f11so49814686qkb.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Mar 2017 13:49:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: mynaramana@gmail.com

Hi Everyone,

My name is Karthik. I am a first year graduate student in Embedded
Systems at University of Pennsylvania. I am a avid c, c++ and python
programmer.I have 4 years of work experience as  Software developer at
Airbus.

I have been working as research assistant in PRECISE lab at the
University of Pennsylvania to evaluate the performance of the Xen's
RTDS scheduler.

Currently, I am doing a course on distributed systems. As a part of
that course ,I am building a small cloud platform using gRPC (Google's
high performance , open-source RPC framework) with the following
features:

(1)Webmail service (SMTP & POP3) to send, receive and forward mails
(2)A fault-tolerant backend server that employs key-Value store
similar to Google's Bigtable.
(3)The entire Bigtable is distributed across multiple backend servers.
(4)Frontend Http server to process requests from a browser, retrieve
appropriate data from the backend server and construct the http
response for the GUI.
(5)Storage service (Similar to Google Drive) with support for
navigating the directories, folder creation and uploading and
downloading any file type.
(6)This system will be fault tolerant with quorum based causal
replication done across multiple nodes and load balancing done with
dynamic distribution of users among different groups.

I compiled and hosted a small cluster to observe how ceph works in
storing the data and how the  distribution of the data is maintained
while ensuring fault tolerance.With the help of my friend Myna
(cc.ed), I could come to speed and performed few experiments to
observe how data is shuffled after bringing down one osd.

I am currently doing literature review on crush algorithm and
understanding the Ceph Architecture.

It would be exciting to work on project "ceph-mgr: Smarter
Reweight-by-Utilization"

Can you point me to any resources that guide to evaluate performace of
storage system ?

What kind of factors should one consider to evaluate performace of a
storage system ?
I could think of response time for reading, writing and deleting a
file or how quickly a node is configured into a cluster or how quickly
cluster heals after a node dies.

Please suggest me some existing simple beginner bug which would give
me a chance to explore the code.

I'm very much interested in Ceph. I want to become a Ceph contributor
in the near future.

Thank you very much for your help!

Best,
Karthik
