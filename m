From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH] auth: Avoid const mismatch when calling nss_aes_operation()
Date: Tue, 26 Apr 2011 15:40:59 -0700
Message-ID: <BANLkTikS-RPRnQGXz5VRBzDop-i573e+EA@mail.gmail.com>
References: <1303851974-29838-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38377 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab1DZWlA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2011 18:41:00 -0400
Received: by fxm17 with SMTP id 17so767571fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2011 15:40:59 -0700 (PDT)
In-Reply-To: <1303851974-29838-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

applied, thanks
C.

On Tue, Apr 26, 2011 at 2:06 PM, Jim Schutt <jaschut@sandia.gov> wrote:
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
> =A0src/auth/Crypto.cc | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/auth/Crypto.cc b/src/auth/Crypto.cc
> index 3dbfd88..757ed79 100644
> --- a/src/auth/Crypto.cc
> +++ b/src/auth/Crypto.cc
> @@ -101,7 +101,7 @@ decrypt(const bufferptr& secret, const bufferlist=
& in, bufferlist& out) const
> =A0# define AES_KEY_LEN =A0 16
> =A0# define AES_BLOCK_LEN =A0 16
>
> -static int nss_aes_operation(CK_ATTRIBUTE_TYPE op, bufferptr& secret=
, const bufferlist& in, bufferlist& out) {
> +static int nss_aes_operation(CK_ATTRIBUTE_TYPE op, const bufferptr& =
secret, const bufferlist& in, bufferlist& out) {
> =A0 const CK_MECHANISM_TYPE mechanism =3D CKM_AES_CBC_PAD;
>
> =A0 // sample source said this has to be at least size of input + 8,
> --
> 1.6.6
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
