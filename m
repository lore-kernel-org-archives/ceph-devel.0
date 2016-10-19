From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: inconsistent problem....
Date: Wed, 19 Oct 2016 11:38:46 +0200
Message-ID: <2ca1eb8d-4ad3-de2f-38d3-4cd81cffbfb8@digiware.nl>
References: <851ba931-f1c8-dc23-7cc4-822efb2c6cab@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:18715 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932446AbcJSO1N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Oct 2016 10:27:13 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id A1C9F2BF4C
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2016 11:38:48 +0200 (CEST)
In-Reply-To: <851ba931-f1c8-dc23-7cc4-822efb2c6cab@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 18-10-2016 15:07, Willem Jan Withagen wrote:
> Hi,
> 
> I have all tests up and running on my development box.
> So I build a Jenkins instance to do regular testing.
> 
> But there readable.sh consistently fails with errors like the one below.
> However it is not always on the smae file, and comparing files with
> those in the repo shows that they are equal.
> 
> Anybody a suggestion of what is going wrong here?
> Memory corruption coudl be one, but then I'd expect other type of
> failures as well.

This turned out to be due to tests being run which should not be run.
I fixed the script: src/test/encoding/readable.sh.

--WjW


