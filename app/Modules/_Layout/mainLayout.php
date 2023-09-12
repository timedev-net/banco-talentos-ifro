<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8">
  <title>Welcome to CodeIgniter 4!</title>
  <meta name="description" content="The small framework with powerful features">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            clifford: '#da373d',
          }
        }
      }
    }
  </script>
  <style type="text/tailwindcss">
    @layer utilities {
        .content-auto {
            content-visibility: auto;
        }
        }
    </style>
  <link rel="shortcut icon" type="image/png" href="/favicon.ico">
</head>

<body>

  <?php echo $this->include('_Layout/topBar');?>

  <?php echo $this->renderSection("conteudo"); ?>


  <footer>
    <div class="environment">
      <p>Page rendered in {elapsed_time} seconds</p>
      <p>Environment:
        <?= ENVIRONMENT ?>
      </p>
    </div>
    <div class="copyrights">
      <p>&copy;
        <?= date('Y') ?> CodeIgniter Foundation. CodeIgniter is open source project released under the MIT
        open source licence.
      </p>
    </div>
  </footer>
  <?php echo $this->renderSection("scripts");?>
</body>

</html>