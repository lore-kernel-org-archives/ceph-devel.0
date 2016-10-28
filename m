From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: ceph-post-file : Permission denied (publickey).
Date: Fri, 28 Oct 2016 12:15:06 +1000
Message-ID: <20161028021506.GE6026@rskikr.localdomain>
References: <89b95e99-73e5-474e-df5f-cbd7927924ed@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34725 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034144AbcJ1CPP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 22:15:15 -0400
Received: by mail-pf0-f181.google.com with SMTP id n85so28012831pfi.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 19:15:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <89b95e99-73e5-474e-df5f-cbd7927924ed@epfl.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yoann Moulin <yoann.moulin@epfl.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On Thu, Oct 27, 2016 at 11:30 PM, Yoann Moulin <yoann.moulin@epfl.ch> wrote:
> Hello,
>
> I tried to upload files with ceph-post-file but got "Permission denied (publickey)."
>
>> $ ceph-post-file 17180.tgz
>> args: -- 17180.tgz
>> /usr/bin/ceph-post-file: upload tag 60a84fdd-b9e9-42cb-817e-5a90e0f9bcf0
>> /usr/bin/ceph-post-file: user: yoann@kveikur
>> /usr/bin/ceph-post-file: will upload file 17180.tgz
>> Permission denied (publickey).
>> Couldn't read packet: Connection reset by peer
>
> do I need to set anything on my side to be able to upload file with this command ?

$ ./bin/ceph-post-file test_file
args: -- test_file
./bin/ceph-post-file: upload tag eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2
./bin/ceph-post-file: user: brad@localhost
./bin/ceph-post-file: will upload file test_file
sftp> mkdir post/eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2_brad@localhost_38cc969c-04af-4d5b-b862-ec9d594d3a3c
sftp> cd post/eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2_brad@localhost_38cc969c-04af-4d5b-b862-ec9d594d3a3c
sftp> put /tmp/tmp.1biVN9avrx user
sftp> put test_file
./bin/ceph-post-file: copy the upload id below to share with a dev:

ceph-post-file: eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2

You can test connectivity with something like the following.

$ sftp -o "IdentityFile=../share/id_rsa_drop.ceph.com" -C -oCheckHostIP=no -oGlobalKnownHostsFile=../share/known_hosts_drop.ceph.com -oBatchMode=no -oIdentitiesOnly=yes -- postfile@drop.ceph.com
Connected to drop.ceph.com.
sftp>

Try running your command as follows to get a better idea what it's doing.

$ bash -x ceph-post-file 17180.tgz

In your case the key may be somewhere other than
/usr/local/share/ceph/id_rsa_drop.ceph.com and may not be being found by the
script. known_hosts_drop.ceph.com should be in the same directory I hope.

-- 
HTH,
Brad


>
> Thanks
>
> --
> Yoann Moulin
> EPFL IC-IT
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
