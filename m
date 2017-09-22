From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: ceph v10.2.10 QE validation status
Date: Fri, 22 Sep 2017 13:24:36 -0700
Message-ID: <CAMMFjmHoKoebggZz6EBjFsG5AyvKPhf9FQAJs7qJXHotrpXQcw@mail.gmail.com>
References: <CAMMFjmHRF8AA3h0Sta==y5XMXNqZBMtwz-nno4hEpVP24EBMcg@mail.gmail.com>
 <CAKPXa=YBHQO4-6kG8-QE2irNruJKfcDJB3BNTw8yX66ZTfcFCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:44529 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdIVUYi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Sep 2017 16:24:38 -0400
Received: by mail-oi0-f50.google.com with SMTP id l74so92065oih.1
        for <ceph-devel@vger.kernel.org>; Fri, 22 Sep 2017 13:24:38 -0700 (PDT)
In-Reply-To: <CAKPXa=YBHQO4-6kG8-QE2irNruJKfcDJB3BNTw8yX66ZTfcFCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Weil, Sage" <sage@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Thu, Sep 21, 2017 at 2:29 PM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
>
>
> On Thu, Sep 21, 2017 at 2:11 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Detailed summary of the QE Validation can be found here
>> http://tracker.ceph.com/issues/20613#note-65
>>
>> rados (subset 227 jobs)
>> rbd
>> rgw
>> fs
>> krbd
>> kcephfs
>> knfs
>> rest
>> hadoop
>> samba
>> ceph-deploy
>> ceph-disk
>> upgrade/client-upgrade
>> upgrade/hammer-x (jewel)
>> upgrade/jewel-x/point-to-point-x
>> powercycle
>> ceph-ansible
>> (please let me know if any suites are missing from this ^ list)
>>
>>
>> ==============================
>> Issues requiring approval/decision:
>>
>> rados - needs Josh review/approval
>> fs - needs Patrick review/approval
>> krbd - approved by Ilya
>> hadoop - EXCLUDED FROM THIS RELEASE
>> samba - EXCLUDED FROM THIS RELEASE
>> upgrade/jewel-x/point-to-point-x Nathan is fixing one issue
>> ceph-ansible -
>> needs Sebastian, Vasu, Andrew review/approval
>
> Ceph-ansible is green and thats what i told in irc as well
> http://pulpito.ceph.com/vasu-2017-09-20_19:51:59-ceph-ansible-jewel-distro-basic-vps/
> (it uses stable-2.1 branch of ceph-ansible)
> The failing tests during purge-cluster at the end can be ignored for now.

I suspect the backporting team does not know about ceph-ansible PRs to
be backported because they  look for issues in the tracker and
ceph-ansible is not there.

https://github.com/ceph/ceph-ansible/issues/1938
Abhishek, Nathan, Vasu, Sebastian ?

>
>>
>> I am not clear on our validation approach for ceph-ansible suite and
>> added a ticket to address it
>> https://github.com/ceph/ceph-ansible/issues/1938
>>
>> Nathan, over after we do minor clean up it feels we will be ready to
>> publish v10.2.10.
>>
>> Thx
>> YuriW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
