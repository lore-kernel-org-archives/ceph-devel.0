From: kefu chai <tchaikov@gmail.com>
Subject: Re: errors in make-debs.sh because "make dist" fails on 'rocksdb/db/slice.cc'
Date: Wed, 24 Aug 2016 00:05:21 +0800
Message-ID: <CAJE9aOPbCc2XKd7LWC2Cg9yawV2PRhKkw-YJoWyzMXDfDSQk_w@mail.gmail.com>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <20160823110125.GG5955@rskikr.localdomain> <20160823112140.GH5955@rskikr.localdomain>
 <cb68488d-2c92-b0dd-cda4-92d3ea149b22@suse.cz> <e367df5c-5995-25dd-fc0b-b5096d757edf@suse.cz>
 <DB5PR05MB1607E0FC452D4FF419A78542A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <a48780cc-bfbf-7b24-32b9-0cd3581b00df@suse.cz> <DB5PR05MB160796FAC0A385F2682873DCA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36417 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbcHWQLF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 12:11:05 -0400
Received: by mail-qk0-f176.google.com with SMTP id l2so111275286qkf.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 09:11:05 -0700 (PDT)
In-Reply-To: <DB5PR05MB160796FAC0A385F2682873DCA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 23, 2016 at 10:09 PM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
> Thanks.
> So, what is the proper way for creating *.deb files

dpkg-buildpackage -j8 -uc --build=binary

>
>> -----Original Message-----
>> From: Nathan Cutler [mailto:ncutler@suse.cz]
>> Sent: Tuesday, August 23, 2016 16:34
>> To: Avner Ben Hanoch <avnerb@mellanox.com>; Brad Hubbard
>> <bhubbard@redhat.com>
>> Cc: Gregory Farnum <gfarnum@redhat.com>; Ceph Development <ceph-
>> devel@vger.kernel.org>
>> Subject: Re: errors in make-debs.sh because "make dist" fails on
>> 'rocksdb/db/slice.cc'
>>
>> > Thanks for the clarification Nathan,
>> >
>> > I am using the updated master branch from https://github.com/ceph/ceph .
>> Anyhow, I don't think the problem is in the file make-debs.sh itself, but in
>> something that is invoked from it regarding make dist with regard to the file
>> db/slice.cc from rocksdb submodule.
>> >
>> > Do you have any idea if someone execute make-debs.sh on the updated
>> ceph master branch?
>>
>> AFAIK you are the first to try it on master.
>>
>> Since the script uses autotools (not cmake) to do the build, it is not expected
>> to work on master. IMO the script needs to be modified.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
