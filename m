From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: ceph-ansible support for Linode cloud VMs w/ SSD storage
Date: Wed, 21 Sep 2016 18:20:14 -0400
Message-ID: <CA+2bHPZBFBNA6uG-qz90Mb89J2A=on+=vwo=Ca4Dq+XOZVWAgQ@mail.gmail.com>
References: <CA+2bHPaV3iBLwfRYR_Aj9XD78j-MKevdtgF48+FSp5mmyKT_TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11412838d2435b053d0bf4ae
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36736 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932337AbcIUWUq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 18:20:46 -0400
Received: by mail-qt0-f182.google.com with SMTP id l91so29803897qte.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 15:20:45 -0700 (PDT)
In-Reply-To: <CA+2bHPaV3iBLwfRYR_Aj9XD78j-MKevdtgF48+FSp5mmyKT_TQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

--001a11412838d2435b053d0bf4ae
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 21, 2016 at 6:04 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> I've also
> attached a Dockerfile which allows you to create a dev environment for
> launching Ceph clusters on Linode.

Of course I forgot to attach the Dockerfile!

-- 
Patrick Donnelly

--001a11412838d2435b053d0bf4ae
Content-Type: application/octet-stream; name="Linode.dockerfile"
Content-Disposition: attachment; filename="Linode.dockerfile"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_itdh2yht0

IyBUaGlzIERvY2tlcmZpbGUgaXMgZm9yIHNldHRpbmcgdXAgYSBkZXYgZW52aXJvbm1lbnQgZm9y
IGxhdW5jaGluZyBDZXBoCiMgY2x1c3RlcnMgb24gTGlub2RlLgoKRlJPTSB1YnVudHU6MTYuMDQK
CldPUktESVIgL3Jvb3QKUlVOIGFwdC1nZXQgdXBkYXRlClJVTiBhcHQtZ2V0IGluc3RhbGwgLXkg
YnVpbGQtZXNzZW50aWFsIGdpdCBhbnNpYmxlIHB5dGhvbi1uZXRhZGRyIHJzeW5jClJVTiB3Z2V0
IC1PIHZhZ3JhbnRfMS44LjVfeDg2XzY0LmRlYiBodHRwczovL3JlbGVhc2VzLmhhc2hpY29ycC5j
b20vdmFncmFudC8xLjguNS92YWdyYW50XzEuOC41X3g4Nl82NC5kZWIKUlVOIGRwa2cgLWkgdmFn
cmFudF8xLjguNV94ODZfNjQuZGViClJVTiBybSAtZiB2YWdyYW50XzEuOC41X3g4Nl82NC5kZWIK
UlVOIHZhZ3JhbnQgcGx1Z2luIGluc3RhbGwgdmFncmFudC1saW5vZGUKIyBEb3dubG9hZCBwYXRj
aCBmcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9kaXNwbGFndWUvdmFncmFudC1saW5vZGUvcHVsbC82
NgpSVU4gd2dldCAtTyAudmFncmFudC5kL2dlbXMvZ2Vtcy92YWdyYW50LWxpbm9kZS0wLjIuNy9s
aWIvdmFncmFudC1saW5vZGUvYWN0aW9ucy9jcmVhdGUucmIgaHR0cHM6Ly9yYXcuZ2l0aHVidXNl
cmNvbnRlbnQuY29tL2JhdHJpY2svdmFncmFudC1saW5vZGUvZGZhMzA1ZGFiOWM1YThiYTQ5YjUw
ZTdkOWQxMTU5OTc3NzA4YzJkMS9saWIvdmFncmFudC1saW5vZGUvYWN0aW9ucy9jcmVhdGUucmIK
UlVOIG1rZGlyIC5zc2ggJiYgc3NoLWtleWdlbiAtZiAuc3NoL2lkX3JzYSAtdCByc2EgLU4gJycK
UlVOIGdpdCBjbG9uZSBodHRwczovL2dpdGh1Yi5jb20vY2VwaC9jZXBoLWFuc2libGUuZ2l0CgpX
T1JLRElSIC9yb290L2NlcGgtYW5zaWJsZQo=
--001a11412838d2435b053d0bf4ae--
