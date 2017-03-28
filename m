From: Methuku Karthik <kmeth@seas.upenn.edu>
Subject: Re: [GSoc] : ceph-mgr: Smarter Reweight-by-Utilization
Date: Tue, 28 Mar 2017 19:54:29 -0400
Message-ID: <CAOnoakd1FO75XhapFHCBz9xwQVrnkxy0YzTe4Faze40a_6JKVQ@mail.gmail.com>
References: <CAOnoake3+pUX0tN4s8VVBxifPFFirOuyQ5Nr7E5icD2z75+1fQ@mail.gmail.com>
 <2110604291.6751836.1490707985018.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33274 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbdC1Xy4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Mar 2017 19:54:56 -0400
Received: by mail-qt0-f176.google.com with SMTP id i34so221101qtc.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Mar 2017 16:54:49 -0700 (PDT)
In-Reply-To: <2110604291.6751836.1490707985018.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kefu Chai <kchai@redhat.com>
Cc: ceph-devel@vger.kernel.org, Myna V <mynaramana@gmail.com>

Hi Kefu Chai,

Thanks for the response.

On Tue, Mar 28, 2017 at 9:33 AM, Kefu Chai <kchai@redhat.com> wrote:
> + ceph-devel
>
> ----- Original Message -----
>> From: "Methuku Karthik" <kmeth@seas.upenn.edu>
>> To: tchaikov@gmail.com, ceph-devel@vger.kernel.org, kchai@redhat.com
>> Cc: mynaramana@gmail.com
>> Sent: Tuesday, March 28, 2017 4:17:52 AM
>> Subject: [GSoc] : ceph-mgr: Smarter Reweight-by-Utilization
>>
>> Hi Everyone,
>>
>> My name is Karthik. I am a first year graduate student in Embedded Systems
>> at University of Pennsylvania. I am a avid c, c++ and python programmer.I
>> have 4 years of work experience as  Software developer at Airbus.
>>
>> I have been working as research assistant in PRECISE lab at the
>> University of Pennsylvania to evaluate the performance of the Xen's RTDS
>> scheduler.
>>
>> Currently, I am doing a course on distributed systems. As a part of that
>> course ,I am building a small cloud platform using gRPC (Google's high
>> performance , open-source RPC framework) with the following features:
>>
>> (1)Webmail service (SMTP & POP3) to send, receive and forward mails
>> (2)A fault-tolerant backend server that employs key-Value store similar to
>> Google's Bigtable.
>> (3)The entire Bigtable is distributed across multiple backend servers.
>> (4)Frontend Http server to process requests from a browser, retrieve
>> appropriate data from the backend server and construct the http response
>> for the GUI.
>> (5)Storage service (Similar to Google Drive) with support for navigating
>> the directories, folder creation and uploading and downloading any file
>> type.
>> (6)This system will be fault tolerant with quorum based causal replication
>> done across multiple nodes and load balancing done with dynamic
>> distribution of users among different groups.
>>
>> I compiled and hosted a small cluster to observe how ceph works in storing
>> the data and how the  distribution of the data is maintained while ensuring
>> fault tolerance.With the help of my friend Myna (cc.ed), I could come to
>> speed and performed few experiments to observe how data is shuffled after
>> bringing down one osd or by adding one osd.
>>
>> I am currently doing literature review on crush algorithm and understanding
>> the Ceph Architecture.
>>
>> It would be exciting to work on project "ceph-mgr: Smarter
>> Reweight-by-Utilization"
>>
>> Can you point me to any resources that guide to evaluate performace of
>> storage system ?
>
> i think the focus of "smarter reweight-by-utilization" would be to have a
> better balanced distribution of data in cluster. there are a lot of related
> discussion recently on our mailing list.
>
>>
>> What kind of factors should one consider to evaluate performace of a
>> storage system ?
>
> latency and throughput, availability, cost, flexibility, etc. i think there
> are lots of factors one should consider. but it depends on the use case.
>
>> I could think of response time for reading, writing and deleting a file or
>> how quickly a node is configured into a cluster or how quickly cluster
>> heals after a node dies.
>>
>> Please suggest me some existing simple beginner bug which would give me a
>> chance to explore the code.
>>
>
> i think it's important for you to find one at http://tracker.ceph.com, or
> better off, to identify a bug by using Ceph.
>

I looked into the bugs marked for ceph-mgr ,Bug #17453 : ceph-mgr
doesn't forget about MDS daemons that have gone away.
Do you think it will be a good start ?

>> I'm very much interested in Ceph. I want to become a Ceph contributor in
>> the near future.
>>
>> Thank you very much for your help!
>>
>> Best,
>> Karthik
>>

Best,
Karthik
