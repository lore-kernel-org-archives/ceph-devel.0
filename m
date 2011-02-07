From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: mkcephfs: clean up temp files, honor $TEMPDIR
Date: Mon, 7 Feb 2011 12:31:13 -0800
Message-ID: <AANLkTimEOiU8p=-A8HRNQD4RBw4DuGBEdmkWZ=xuY_E-@mail.gmail.com>
References: <AANLkTimDUUKq4EAEQdu4E6PKAvp4VP4NEK3GJ20ttnty@mail.gmail.com>
	<AANLkTikESf2F0OGcaxhGUu_vGbVRfP2kyPnGaUqmtvWS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54345 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1BGUbP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 15:31:15 -0500
Received: by eye27 with SMTP id 27so2599248eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Feb 2011 12:31:14 -0800 (PST)
In-Reply-To: <AANLkTikESf2F0OGcaxhGUu_vGbVRfP2kyPnGaUqmtvWS@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: ceph-devel@vger.kernel.org

This is resolved by aa8a25592f442ab640708115e144e6b8d95cb664, give it a try!

C.


On Sun, Feb 6, 2011 at 10:02 PM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> On Sun, Feb 6, 2011 at 5:33 AM, DongJin Lee <dongjin.lee@auckland.ac.nz> wrote:
>> Hi all:
>>
>> commit 09c38e8edadb3a5bf470ff9b0409172e0c61e012
>> About introducing the new tmp directory.
>>
>> TDIR=`mktemp -d -t mkcephfs.XXXXXXXXXX` || exit 1
>> trap "rm -rf ${TDIR}; exit" INT TERM EXIT
>>
>> I think this works if running all on the same nodes.
>> but other nodes don't know this directory name as they don't yet have
>> this newly (and randomly) created directory.
>
> Yes, the scp should be fixed. Good find.
>
>> Also, in the line 193, scp -q $conf $host:$conf
>> I don't think we check whether nodes have config directory, e.g., for
>> -c /etc/ceph/ceph.conf, we don't check /etc/ceph directory?
>> and so the other custom directory would also fail, too I think.
>
> I suppose we should do a mkdir -p before copying over the configuration file.
>
> cheers,
> Colin
>
