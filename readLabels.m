function [labels, frame_labels, label_colors] = readLabels(store)
  labels = {'beverages', 'bread', 'cereal', 'cheese', 'counter', 'dairy', 'entrance', 'flowers', 'frozenfood', 'health', 'meat', 'none', 'oils', 'pasta', 'snacks', 'vegetables', 'water'};

  fps = 25;
  lfname = sprintf('labels_%s.txt', store);
  lfid = fopen(lfname);
  frame_labels = zeros(681,2);
  line = textscan(lfid, '%d:%d %s', 1);
  line_lbls = split(line{3}, ':');
  st = line{1} * 60 + line{2}; pllabel = find(strcmp(labels, line_lbls(1))); prlabel = find(strcmp(labels, line_lbls(2)));
  while true
    line = textscan(lfid, '%d:%d %s', 1);
    if ~isempty(line{1})
      line_lbls = split(line{3}, ':');
      et = line{1} * 60 + line{2}; llabel = find(strcmp(labels, line_lbls(1))); rlabel = find(strcmp(labels, line_lbls(2)));
      for i = st:et-1
        frame_labels(i+1,1) = pllabel;
        frame_labels(i+1,2) = prlabel;
      end
      st = et; pllabel = llabel; prlabel = rlabel;
    else
      break
    end
  end
  et = 680;
  for i = st:et
    frame_labels(i+1,1) = pllabel;
    frame_labels(i+1,2) = prlabel;
  end
  fclose(lfid);

  label_colors = rand(size(labels,2), 3);
  % matlab standard colors + couple others
  label_colors = [ 
                0, 0.4470, 0.7410;
          	0.8500, 0.3250, 0.0980;
          	0.9290, 0.6940, 0.1250;
          	0.4940, 0.1840, 0.5560;
          	0.4660, 0.6740, 0.1880;
          	0.3010, 0.7450, 0.9330;
          	0.6350, 0.0780, 0.1840;
                0, 0, 1;
          	0, 0.5, 0;
          	1, 0, 0;
          	0, 0.75, 0.75;
          	0.75, 0, 0.75;
          	0.75, 0.75, 0;
          	0.25, 0.25, 0.25;
                0, 0.2, 0.2;
                0.8510, 0.9569, 0.2588;
                0.36, 0.2588, 0.9569;
                ];
end
